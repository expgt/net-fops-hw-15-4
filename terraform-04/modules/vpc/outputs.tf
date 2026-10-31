output "network_id" {
  value       = yandex_vpc_network.vpc_dev.id
  description = "The unique identifier of the created VPC network"
}

output "subnets" {
  value       = yandex_vpc_subnet.vpc_dev
  description = "A map of all created subnet resources, keyed by their availability zones"
}