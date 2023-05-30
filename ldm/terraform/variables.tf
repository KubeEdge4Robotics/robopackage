/*
 * 华为云账号信息输入值，TODO RFS不支持object类型，需要拆分为多个基础变量
 */
variable "ak" {
  type = string
}

variable "sk" {
  type = string
}

variable "region" {
  type    = string
  default = "cn-south-1"
}

/*
 * 密码信息
 */
variable "rds_password" {
  type    = string
  default = "robo@123"
}

variable "dcs_password" {
  type    = string
  default = "robo@123"
}

variable "cce_node_password" {
  type    = string
  default = "robo@123"
}

/*
 * 可用区信息输入值
 */
variable "az" {
  type    = list(string)
  default = [
    "cn-south-2b",
    "cn-south-1f",
    "cn-south-1c",
    "cn-south-1e",
  ]
}
