resource "huaweicloud_cce_cluster" "cce_ldm" {
  name                         = "cce-ldm"
  flavor_id                    = "cce.s2.medium"
  cluster_version              = "v1.23"
  vpc_id                       = huaweicloud_vpc.vpc_ldm.id
  subnet_id                    = huaweicloud_vpc_subnet.subnet_center.id
  container_network_type       = "eni" // 云原生容器网络2.0
  eni_subnet_id                = huaweicloud_vpc_subnet.subnet_center.ipv4_subnet_id
  eni_subnet_cidr              = huaweicloud_vpc_subnet.subnet_center.cidr
  enable_distribute_management = true

  // 将kubeconfig保存到本地
  provisioner "local-exec" {
    command = "echo '${huaweicloud_cce_cluster.cce_ldm.kube_config_raw}' > ./resources/kubeconfig.json"
  }
}

/*
 * 虽然terraform-huaweicloud-provider已经实现CCE Partitions模块：
 *  - https://github.com/chnsz/golangsdk/pull/323
 *  - https://github.com/huaweicloud/terraform-provider-huaweicloud/pull/2956
 * 但是CCE暂未注册partitions相关接口到现网APIG，因此还无法使用，故使用下方脚本创建partition分区
resource "huaweicloud_cce_partition" "edge_part" {
  cluster_id           = huaweicloud_cce_cluster.cce_ldm.id
  category             = "IES"
  availability_zone    = var.az_ies
  partition_subnet_id  = huaweicloud_vpc_subnet.subnet_edge.id
  container_subnet_ids = [huaweicloud_vpc_subnet.subnet_edge.ipv4_subnet_id]
}
*/

data "huaweicloud_identity_projects" "myproject" {
  name = var.user_account.region
}

// 使用脚本创建partition分区
resource "null_resource" "cce_partition" {
  provisioner "local-exec" {
    command = <<-EOT
curl -s -o /tmp/cce_login.log \
--cookie-jar /tmp/cookies.txt \
--location ${var.console_url.login} \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'userpasswordcredentials.domain=${var.user_account.domain}' \
--data-urlencode 'userpasswordcredentials.username=${var.user_account.username}' \
--data-urlencode 'userpasswordcredentials.password=${urlencode(var.user_account.password)}' \
--data-urlencode 'userpasswordcredentials.userInfoType=name';

export cftk=$(cat /tmp/cookies.txt | grep cftk | awk '{print $7}');

export status_code=$(curl -s -o /tmp/cce_create_partition.log -w "%%{http_code}" \
-b /tmp/cookies.txt \
--location '${var.console_url.cce}/${data.huaweicloud_identity_projects.myproject.projects[0].id}/clusters/${huaweicloud_cce_cluster.cce_ldm.id}/partitions' \
--header 'Content-Type: application/json' \
--header 'cftk: '$cftk'' \
--data '{
  "kind": "Cluster",
  "apiVersion": "v3",
  "metadata": {
    "name": "${var.az.ies}"
  },
  "spec": {
    "hostNetwork": {
      "subnetID": "${huaweicloud_vpc_subnet.subnet_edge.id}"
    },
    "containerNetwork": [
      {
        "subnetID": "${huaweicloud_vpc_subnet.subnet_edge.ipv4_subnet_id}"
      }
    ],
    "publicBorderGroup": "${var.az.ies}",
    "category": "IES"
  }
}')

if [ $status_code -ne 201 ]; then cat /tmp/cce_create_partition.log; exit 1; fi
EOT
  }
}

resource "random_password" "cce_node_password" {
  length           = 12
  special          = true
  override_special = "!@$%^*-_=+"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "huaweicloud_cce_node" "cce_ies_node" {
  depends_on = [null_resource.cce_partition]
  count      = 2

  cluster_id        = huaweicloud_cce_cluster.cce_ldm.id
  name              = "cce-ies-node-${count.index+1}"
  availability_zone = var.az.ies
  partition         = var.az.ies
  flavor_id         = var.cce.node_flavor.az_ies
  os                = "EulerOS 2.9"
  runtime           = "docker"
  password          = random_password.cce_node_password.result

  root_volume {
    size       = 40
    volumetype = "SSD"
  }
  data_volumes {
    size       = 100
    volumetype = "SSD"
  }
}

// 创建云上CCE工作节点，用于执行初始化脚本
resource "huaweicloud_cce_node" "init_node" {
  depends_on = [
    huaweicloud_cce_node.cce_ies_node,
    // 等待resources目录下所有文件上传到OBS后，再创建此CCE节点
    huaweicloud_obs_bucket_object.ldm_sql,
    huaweicloud_obs_bucket_object.kube_config,
    huaweicloud_obs_bucket_object.post_install,
    huaweicloud_obs_bucket_object.helm_cli,
    huaweicloud_obs_bucket_object.helm_install,
    huaweicloud_obs_bucket_object.outputs,
  ]

  cluster_id        = huaweicloud_cce_cluster.cce_ldm.id
  name              = "cce-init-node"
  availability_zone = var.az.center
  flavor_id         = var.cce.node_flavor.az_center
  os                = "EulerOS 2.9"
  runtime           = "docker"
  password          = random_password.cce_node_password.result
  postinstall       = base64encode("curl https://${huaweicloud_obs_bucket.ldm_res.bucket}.obs.${var.user_account.region}.myhuaweicloud.com/${huaweicloud_obs_bucket_object.post_install.key} -o /tmp/post_install.sh && bash -x /tmp/post_install.sh ${huaweicloud_rds_instance.rds_ldm.private_ips[0]} ${huaweicloud_rds_instance.rds_ldm.db[0].password} > /tmp/post_install.log 2>&1\n")

  root_volume {
    size       = 40
    volumetype = "SSD"
  }
  data_volumes {
    size       = 100
    volumetype = "SSD"
  }
}
