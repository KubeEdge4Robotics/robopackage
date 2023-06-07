/*
 * RDS相关输出值
 */
output "rds_host_ip" {
    value = huaweicloud_rds_instance.rds_ldm.private_ips[0]
}
output "rds_username" {
    value = huaweicloud_rds_instance.rds_ldm.db[0].user_name
}

output "rds_password" {
    sensitive = true
    value     = huaweicloud_rds_instance.rds_ldm.db[0].password
}

output "rds_db_name" {
    value = huaweicloud_rds_mysql_database.ldm.name
}

/*
 * DCS相关输出值
 */
output "dcs_host_ip" {
  value = huaweicloud_dcs_instance.dcs_ldm.private_ip
}

output "dcs_password" {
    sensitive = true
    value     = huaweicloud_dcs_instance.dcs_ldm.password
}

/*
 * CCE相关输出值
 */
output "cce_node_password" {
    sensitive = true
    value     = huaweicloud_cce_node.cce_node[0].password
}
