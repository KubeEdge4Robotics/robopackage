resource "huaweicloud_cce_cluster" "cce_ldm" {
  name                         = "cce-ldm"
  flavor_id                    = "cce.s2.small"
  cluster_version              = "v1.23"
  vpc_id                       = huaweicloud_vpc.vpc_ldm.id
  subnet_id                    = huaweicloud_vpc_subnet.subnet_center.id
  container_network_type       = "vpc-router"
  eni_subnet_id                = huaweicloud_vpc_subnet.subnet_center.ipv4_subnet_id
  eni_subnet_cidr              = huaweicloud_vpc_subnet.subnet_center.cidr
  charging_mode                = "prePaid"
  period_unit                  = "month"
  period                       = 1
  auto_renew                   = true

  // 将kubeconfig保存到本地
  provisioner "local-exec" {
    command = "echo '${huaweicloud_cce_cluster.cce_ldm.kube_config_raw}' > kubeconfig.json"
  }

  // 将输出值整理到outputs.yaml
  provisioner "local-exec" {
    command = <<-EOT
cat <<EOF>outputs.yaml
outputs:
  rds_host_ip: ${huaweicloud_rds_instance.rds_ldm.private_ips[0]}
  rds_username: ${huaweicloud_rds_instance.rds_ldm.db[0].user_name}
  rds_password: ${huaweicloud_rds_instance.rds_ldm.db[0].password}
  rds_db_name: ${huaweicloud_rds_mysql_database.ldm.name}
  dcs_host_ip: ${huaweicloud_dcs_instance.dcs_ldm.private_ip}
  dcs_password: ${huaweicloud_dcs_instance.dcs_ldm.password}
EOF
EOT
  }
}

resource "huaweicloud_cce_node" "work_node" {
  cluster_id        = huaweicloud_cce_cluster.cce_ldm.id
  name              = "cce-ldm-node1"
  availability_zone = var.az[2]
  flavor_id         = "c7.2xlarge.2"
  os                = "EulerOS 2.9"
  runtime           = "docker"
  password          = var.cce_node_password
  charging_mode     = "prePaid"
  period_unit       = "month"
  period            = 1
  auto_renew        = true

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
  password          = var.cce_node_password
  postinstall       = base64encode("curl https://${var.obs_res_bucket}.obs.${var.region}.myhuaweicloud.com/post_install.sh -o /tmp/post_install.sh && bash -x /tmp/post_install.sh ${var.ak} ${var.sk} ${var.region} ${var.obs_res_bucket} > /tmp/post_install.log 2>&1")
  charging_mode     = "prePaid"
  period_unit       = "month"
  period            = 1
  auto_renew        = true

  root_volume {
    size       = 40
    volumetype = "SSD"
  }
  data_volumes {
    size       = 100
    volumetype = "SSD"
  }
}
