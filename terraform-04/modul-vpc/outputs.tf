output "network_id" {
  value       = module.vpc_dev.network_id
  description = "The network ID to be consumed by remote state"
}

output "subnets" {
  value       = module.vpc_dev.subnets
  description = "The subnet map to be consumed by remote state"
}