terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">=1.44.1"
    }
  }
}

provider "huaweicloud" {
  region     = var.region
  access_key = var.ak
  secret_key = var.sk
}
