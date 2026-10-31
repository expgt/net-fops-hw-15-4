variable "token" {
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  type        = string  
}

variable "folder_id" {
  type        = string
}


variable "default_zone" { 
    type = string
    default = "ru-central1-d"
}

variable "env_name" {
    type = string
    default = "develop"
}

variable "instance_count" {
    type = number
    default = 1
}

variable "platform" {
    type = string
    default = "standard-v2"
}

variable "image_family" {
    type = string
    default = "ubuntu-2004-lts"
}

variable "public_ip" { 
    type = bool
    default = true
}

variable "label_owner" {
  type        = string
  default     = "devops"
  description = "label owner"
}

variable "serial_port" {
    type = number
    default = 1
}

variable "ssh_public_key" {
    type = string
}

variable "access_key_id" {
    type = string
}

variable "secret_key_id" {
    type = string
    sensitive = true
}
