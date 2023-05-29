/*
 * 华为云账号信息输入值
 */
variable "user_account" {
  type = object({
    ak       = string
    sk       = string
    domain   = string
    username = string
    password = string
    region   = string
  })
  sensitive = true
}

/*
 * 华为云服务控制台访问链接输入值
 */
variable "console_url" {
  type = object({
    login = string
    cce   = string
  })
  default = {
    login = "https://auth.huaweicloud.com/authui/validateUser.action?service=https://console.huaweicloud.com/console/"
    cce   = "https://console.huaweicloud.com/cce2.0/rest/cce/api/v3/projects"
  }
}

/*
 * 可用区相关输入值
 */
variable "az" {
  type = object({
    center = string
    ies    = string
  })
  default = {
    center = "cn-south-1c"           // 中心可用区
    ies    = "cn-south-1-ies-fstxz"  // IES边缘可用区，来自hwstaff_ies测试账号的IES边缘可用区
  }
}

/*
 * CCE相关输入值
 */
variable "cce" {
  type = object({
    node_flavor = object({  // CCE工作节点规格
      az_center = string
      az_ies    = string
    })
  })
  default = {
    node_flavor = {
      az_center = "c7.xlarge.2"      // 通用计算增强型 - 4核 | 8GiB
      az_ies    = "c6sne.2xlarge.2"  // 容器增强型    - 8核 | 16GiB
    }
  }
}
