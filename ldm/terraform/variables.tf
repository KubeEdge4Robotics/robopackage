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
  type = string
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
