resource "huaweicloud_cce_cluster" "cce_ldm" {
  name                         = "cce-ldm"
  flavor_id                    = "cce.s2.small"
  cluster_version              = "v1.23"
  vpc_id                       = huaweicloud_vpc.vpc_ldm.id
  subnet_id                    = huaweicloud_vpc_subnet.subnet_center.id
  container_network_type       = "vpc-router"
  eni_subnet_id                = huaweicloud_vpc_subnet.subnet_center.ipv4_subnet_id
  eni_subnet_cidr              = huaweicloud_vpc_subnet.subnet_center.cidr

  // 将kubeconfig保存到本地
  provisioner "local-exec" {
    command = "echo '${huaweicloud_cce_cluster.cce_ldm.kube_config_raw}' > kubeconfig.json"
  }
}

resource "random_password" "cce_node_password" {
  length           = 12
  special          = true
  override_special = "!@$%"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "huaweicloud_cce_node" "work_node" {
  cluster_id        = huaweicloud_cce_cluster.cce_ldm.id
  name              = "cce-ldm-node1"
  availability_zone = var.az[2]
  flavor_id         = "c7.2xlarge.2"
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
  // 等待resources目录下的文件上传到OBS后，再创建此CCE节点
  depends_on = [
    huaweicloud_obs_bucket_object.kube_config,
    huaweicloud_obs_bucket_object.outputs,
  ]

  cluster_id        = huaweicloud_cce_cluster.cce_ldm.id
  name              = "cce-ldm-node2"
  availability_zone = var.az[2]
  flavor_id         = "c7.2xlarge.2"
  os                = "EulerOS 2.9"
  runtime           = "docker"
  password          = random_password.cce_node_password.result
  postinstall       = base64encode("curl https://ldm-res.obs.${var.region}.myhuaweicloud.com/post_install.sh -o /tmp/post_install.sh && bash -x /tmp/post_install.sh ${var.ak} ${var.sk} ${var.region} > /tmp/post_install.log 2>&1")

  root_volume {
    size       = 40
    volumetype = "SSD"
  }
  data_volumes {
    size       = 100
    volumetype = "SSD"
  }
}
