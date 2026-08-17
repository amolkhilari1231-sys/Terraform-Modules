output "resource_groups" {
  value       = module.resource_group
  description = "Created resource groups details"
}

output "virtual_networks" {
  value       = module.virtual_network
  description = "Created virtual networks details"
}

output "public_ips" {
  value       = module.pip
  description = "Created public IP addresses details"
}
