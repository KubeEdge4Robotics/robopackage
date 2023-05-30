terraform {
  required_version = ">= 0.13.5"

  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.47.1"
    }
  }
}

provider "huaweicloud" {
  region     = var.user_account.region
  access_key = var.user_account.ak
  secret_key = var.user_account.sk
}
