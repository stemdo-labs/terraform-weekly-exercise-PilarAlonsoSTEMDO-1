output "subnet_ids" {
  description = "IDs de las subnets creadas."
  value       = values(azurerm_subnet.subnet)[*].id
}