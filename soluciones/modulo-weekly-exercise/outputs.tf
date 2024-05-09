output "virtual_network_ids" {
  value = azurerm_virtual_network.example[*].id
}
