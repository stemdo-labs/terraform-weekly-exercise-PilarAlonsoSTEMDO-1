provider "azurerm" {
  features {}
}



resource "azurerm_resource_group" "example" {
  name     = var.existent_resource_group_nombre
  location = var.location["network"]
}

locals {
  vnet_instances = {
    for instance in var.vm_instances : instance.vnet_name => instance
  }
}

resource "azurerm_virtual_network" "example" {
  for_each = local.vnet_instances

  name                = each.value.vnet_name
  address_space       = each.value.vnet_address_space
  location            = each.value.location
  resource_group_name = azurerm_resource_group.example.name

  tags = {
    owner       = each.value.owner_tag
    environment = each.value.environment_tag
  }
}


