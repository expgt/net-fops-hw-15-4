variable "env_name" {
  type        = string
  description = "env name"
}

# variable "zone" {
#   type        = string
#   description = "zone"
# }

# variable "v4_cidr_blocks" {
#   type        = string
#   description = "CIDR IPv4"
# }

# variable "env_name" {
#   type        = string
#   description = "The name of the infrastructure environment (e.g., develop, production)"
# }

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  description = "List of subnet objects containing zone names and corresponding CIDR blocks"
}
