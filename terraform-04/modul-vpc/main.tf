terraform {
  required_providers {
    yandex = { source = "yandex-cloud/yandex" }
  }
  required_version = "~>1.16.0"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    
    bucket                      = "my-unique-develop-bucket-1gb"
    key                         = "vpc/terraform.tfstate"
    region                      = "ru-central1"
    
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}

# provider "yandex" {
#   token     = var.token
#   cloud_id  = var.cloud_id
#   folder_id = var.folder_id
# }

module "vpc_dev" {
  source   = "../modules/vpc"
  env_name = "develop"
  subnets = [
    { zone = "ru-central1-d", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-e", cidr = "10.0.2.0/24" }
  ]
}
