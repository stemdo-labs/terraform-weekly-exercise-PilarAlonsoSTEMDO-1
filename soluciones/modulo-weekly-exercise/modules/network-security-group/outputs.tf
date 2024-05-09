output "network_security_group_ids" {
  description = "IDs de los grupos de seguridad de red creados."
  value       = values(azurerm_network_security_group.nsg)[*].id
}