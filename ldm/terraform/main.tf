terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">=1.46.0"
    }
  }
}

provider "huaweicloud" {
  region                = var.region
  access_key            = var.ak
  secret_key            = var.sk
  enterprise_project_id = var.enterprise_project_id
}
