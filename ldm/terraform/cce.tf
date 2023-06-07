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
}

resource "huaweicloud_cce_node" "cce_node" {
  count             = 2
  cluster_id        = huaweicloud_cce_cluster.cce_ldm.id
  name              = "cce-ldm-node${count.index+1}"
  availability_zone = var.az[2]
  flavor_id         = "c7.xlarge.2"
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
