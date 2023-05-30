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
    value     = random_password.rds_password.result
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
    value     = random_password.dcs_password.result
}

/*
 * CCE相关输出值
 */
output "cce_node_password" {
    sensitive = true
    value     = random_password.cce_node_password.result
}

///////HELM///////
// 将输出值整理到./resources/outputs.yaml
resource "null_resource" "outputs" {
    provisioner "local-exec" {
        command = <<-EOT
cat <<EOF > ./resources/outputs.yaml
outputs:
  rds_host_ip: ${huaweicloud_rds_instance.rds_ldm.private_ips[0]}
  rds_username: ${huaweicloud_rds_instance.rds_ldm.db[0].user_name}
  rds_password: ${random_password.rds_password.result}
  rds_db_name: ${huaweicloud_rds_mysql_database.ldm.name}
  dcs_host_ip: ${huaweicloud_dcs_instance.dcs_ldm.private_ip}
  dcs_password: ${random_password.dcs_password.result}
EOF
EOT
    }
}
