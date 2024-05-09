existent_resource_group_nombre = "MyResourcePalonso"
vnet_name = {
  "frontend" = "vnet-frontend-dev"
  "backend"  = "vnet-backend-prod"
}

vnet_address_space = {
  "frontend" = ["10.1.0.0/24"]
  "backend"  = ["10.2.0.0/24"]
}

location = {
  "frontend" = "West Europe"
  "backend"  = "North Europe"
}

owner_tag = {
  "frontend" = "frontend-team"
  "backend"  = "backend-team"
}

environment_tag = {
  "frontend" = "dev"
  "backend"  = "prod"
}

vnet_tags = {
  "department" = "IT"
  "project"    = "ProjectX"
}

vm_instances = {
  "frontend-instance" = {
    vnet_name          = var.vnet_name["frontend"]
    vnet_address_space = var.vnet_address_space["frontend"]
    location           = var.location["frontend"]
    owner_tag          = var.owner_tag["frontend"]
    environment_tag    = var.environment_tag["frontend"]
    vnet_tags          = var.vnet_tags
  },
  "backend-instance" = {
    vnet_name          = var.vnet_name["backend"]
    vnet_address_space = var.vnet_address_space["backend"]
    location           = var.location["backend"]
    owner_tag          = var.owner_tag["backend"]
    environment_tag    = var.environment_tag["backend"]
    vnet_tags          = var.vnet_tags
  }
}
