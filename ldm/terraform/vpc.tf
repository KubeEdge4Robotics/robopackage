resource "huaweicloud_vpc" "vpc_ldm" {
  name = "vpc-ldm"
  cidr = "192.168.0.0/16"
}

resource "huaweicloud_vpc_subnet" "subnet_center" {
  name              = "subnet-center"
  cidr              = "192.168.0.0/24"
  gateway_ip        = "192.168.0.1"
  vpc_id            = huaweicloud_vpc.vpc_ldm.id
  dns_list          = ["100.125.136.29", "100.125.1.250"]
  availability_zone = var.az.center
  description       = "中心可用区子网"
}

resource "huaweicloud_vpc_subnet" "subnet_edge" {
  name              = "subnet-edge"
  cidr              = "192.168.1.0/24"
  gateway_ip        = "192.168.1.1"
  vpc_id            = huaweicloud_vpc.vpc_ldm.id
  dns_list          = ["100.125.136.29", "100.125.1.250"]
  availability_zone = var.az.ies
  description       = "IES边缘可用区子网"
}
