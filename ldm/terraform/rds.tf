/*
 * 配置RDS实例安全组
 */
resource "huaweicloud_networking_secgroup" "sg_rds_ldm" {
  name        = "sg-rds-ldm"
  description = "此安全组入方向全部放通，只能让服务于LDM的RDS实例绑定，安全起见绑定此安全组的RDS本身不允许挂公网IP"
}

resource "huaweicloud_networking_secgroup_rule" "all_pass_rule" {
  security_group_id = huaweicloud_networking_secgroup.sg_rds_ldm.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
}

/*
 * 配置RDS实例
 */
data "huaweicloud_rds_flavors" "rds_flavors" {
  db_type           = "MySQL"
  db_version        = "8.0"
  instance_mode     = "ha"
  group_type        = "general"
  memory            = 4
  vcpus             = 2
}

resource "huaweicloud_rds_instance" "rds_ldm" {
  name                = "rds-ldm"
  flavor              = data.huaweicloud_rds_flavors.rds_flavors.flavors[0].name
  ha_replication_mode = "semisync"
  vpc_id              = huaweicloud_vpc.vpc_ldm.id
  subnet_id           = huaweicloud_vpc_subnet.subnet_center.id
  security_group_id   = huaweicloud_networking_secgroup.sg_rds_ldm.id
  availability_zone   = [var.az[0], var.az[1]]
  charging_mode       = "prePaid"
  period_unit         = "month"
  period              = 1
  auto_renew          = true
  db {
    type     = "MySQL"
    version  = "8.0"
    password = var.rds_password
  }
  volume {
    type = "CLOUDSSD"
    size = 40
  }
}

/*
 * 创建ldm数据库
 */
resource "huaweicloud_rds_mysql_database" "ldm" {
  instance_id   = huaweicloud_rds_instance.rds_ldm.id
  name          = "ldm"
  character_set = "utf8"
}

// TODO 数据库表的创建放在CCE工作节点创建完毕后，由CCE工作节点启动脚本完成
