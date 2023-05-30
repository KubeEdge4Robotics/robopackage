/*
 * 华为云账号信息输入值
 */
variable "user_account" {
  type = object({
    ak       = string
    sk       = string
    region   = string
  })
  sensitive = true
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
