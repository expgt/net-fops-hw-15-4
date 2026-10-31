variable "cluster_id" {
  type        = string
  description = "The unique identifier of the target MySQL cluster"
}

variable "db_name" {
  type        = string
  description = "The name of the database to be created"
}

variable "user_name" {
  type        = string
  description = "The name of the database user"
}

variable "user_password" {
  type        = string
  description = "The password for the database user"
  sensitive   = true
}