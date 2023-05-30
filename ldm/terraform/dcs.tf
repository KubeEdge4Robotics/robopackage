data "huaweicloud_dcs_flavors" "dcs_flavors" {
  capacity       = "4"
  engine         = "Redis"
  engine_version = "6.0"
  cache_mode     = "ha"
}

resource "random_password" "dcs_password" {
  length           = 12
  special          = true
  override_special = "~!@#$^&*()-_=+|{}:,<.>/?"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "huaweicloud_dcs_instance" "dcs_ldm" {
  name               = "dcs-ldm"
  engine             = "Redis"
  engine_version     = "6.0"
  capacity           = "4"
  flavor             = data.huaweicloud_dcs_flavors.dcs_flavors.flavors[0].name
  password           = random_password.dcs_password.result
  vpc_id             = huaweicloud_vpc.vpc_ldm.id
  subnet_id          = huaweicloud_vpc_subnet.subnet_center.id
  availability_zones = [var.az[2], var.az[3]]
}
