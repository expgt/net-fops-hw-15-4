variable "cluster_name" {
  type        = string
  description = "The name of the managed MySQL cluster"
}

variable "network_id" {
  type        = string
  description = "The unique identifier of the VPC network"
}

variable "subnets" {
  type        = any
  description = "Map of subnets from the VPC module"
}

variable "zone" {
  type        = string
  default     = "ru-central1-d"
  description = "The availability zone for the primary database host"
}

variable "alternative_zone" {
  type        = string
  default     = "ru-central1-e"
  description = "The availability zone for the secondary database host"
}

variable "HA" {
  type        = bool
  default     = false
  description = "High Availability flag"
}
