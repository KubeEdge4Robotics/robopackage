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
data "huaweicloud_rds_flavors" "rds_edge_flavor" {
  db_type           = "MySQL"
  db_version        = "8.0"
  instance_mode     = "ha"
  availability_zone = var.az.ies
  memory            = 8
  vcpus             = 4
}

resource "random_password" "rds_password" {
  length           = 12
  special          = true
  override_special = "!@$%^*-_=+"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "huaweicloud_rds_instance" "rds_ldm" {
  name                = "rds-ldm"
  flavor              = data.huaweicloud_rds_flavors.rds_edge_flavor.flavors[0].name
  ha_replication_mode = "semisync"
  vpc_id              = huaweicloud_vpc.vpc_ldm.id
  subnet_id           = huaweicloud_vpc_subnet.subnet_edge.id
  security_group_id   = huaweicloud_networking_secgroup.sg_rds_ldm.id
  availability_zone   = [var.az.ies, var.az.ies] // 主备可用区都只能是IES边缘可用区
  db {
    type     = "MySQL"
    version  = "8.0"
    password = random_password.rds_password.result
  }
  volume {
    type = "EDGESSD" // 边缘SSD云盘
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
