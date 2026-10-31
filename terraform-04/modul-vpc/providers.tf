provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

provider "aws" {
  access_key                  = "mock_key"
  secret_key                  = "mock_secret"
  region                      = "us-east-1"
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}