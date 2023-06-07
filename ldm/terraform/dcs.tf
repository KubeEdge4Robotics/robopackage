data "huaweicloud_dcs_flavors" "dcs_flavors" {
  capacity       = "0.5"
  engine         = "Redis"
  engine_version = "5.0"
  cache_mode     = "ha"
}

resource "huaweicloud_dcs_instance" "dcs_ldm" {
  name               = "dcs-ldm"
  engine             = "Redis"
  engine_version     = "5.0"
  capacity           = "0.5"
  flavor             = data.huaweicloud_dcs_flavors.dcs_flavors.flavors[0].name
  password           = var.dcs_password
  vpc_id             = huaweicloud_vpc.vpc_ldm.id
  subnet_id          = huaweicloud_vpc_subnet.subnet_center.id
  availability_zones = [var.az[2], var.az[3]]
  charging_mode      = "prePaid"
  period_unit        = "month"
  period             = 1
  auto_renew         = true
}
