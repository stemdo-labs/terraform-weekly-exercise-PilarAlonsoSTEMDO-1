

resource "azurerm_resource_group" "example" {
  name     = var.existent_resource_group_nombre
  location = var.location
}

#creo la red virtual o redes virtuales
resource "azurerm_virtual_network" "example" {
  count               = length(var.vm_instances)
  name                = var.vm_instances[count.index].vnet_name
  address_space       = var.vm_instances[count.index].vnet_address_space
  location            = var.vm_instances[count.index].location
  resource_group_name = azurerm_resource_group.example.name

  tags = {
    owner       = var.vm_instances[count.index].owner_tag
    environment = var.vm_instances[count.index].environment_tag
  }
}

# Creación de subnets
module "subnet" {
  source         = "./subnet"
  vnet_name      = azurerm_virtual_network.example.name
  resource_group = azurerm_resource_group.rg.name
  subnets       = var.subnets
}

# Creación de grupos de seguridad de red
module "network_security_group" {
  source                    = "./network_security_group"
  resource_group            = azurerm_resource_group.rg.name
  location                  = var.location
  network_security_groups   = var.network_security_groups
}
output "network_security_group_ids" {
  value = module.network_security_group.network_security_group_ids
}
# Asociación de subnets con grupos de seguridad de red
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  for_each                 = var.subnets

  subnet_id                = module.subnet.subnet_ids[each.value.subnet_ids]
  network_security_group_id = module.network_security_group.network_security_group_ids[each.value.security_group]
}


####
# Creación de las interfaces de red
resource "azurerm_network_interface" "my_nic" {
  count                 = length(var.vm_instances)
  name                  = "${var.network_interface_name}${count.index}"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "ipconfig${count.index}"
    subnet_id                     = azurerm_subnet_network_security_group_association.subnet_nsg_association[count.index].subnet_id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
  }
}

# Asociación de las interfaces de red con el grupo de direcciones de backend del balanceador de carga
resource "azurerm_network_interface_backend_address_pool_association" "my_nic_lb_pool" {
  count                   = length(azurerm_network_interface.my_nic)
  network_interface_id    = azurerm_network_interface.my_nic[count.index].id
  ip_configuration_name   = "ipconfig${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.my_lb_pool.id
}

module "virtual_machines" {
  source                  = "./virtual_machines"  # Ruta al directorio del módulo de máquinas virtuales
  existent_resource_group_nombre = var.existent_resource_group_nombre
  location                = var.location
  network_interface_ids   = var.network_interface_ids
  virtual_machine_name    = var.virtual_machine_name
  virtual_machine_size    = var.virtual_machine_size
  disk_name               = var.disk_name
  redundancy_type         = var.redundancy_type
  username                = var.username
  password                = var.password
  disable_password_authentication = var.disable_password_authentication
  vm_instances            = var.vm_instances
}


# Creación del balanceador de carga público
resource "azurerm_lb" "my_lb" {
  name                = var.load_balancer_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.public_ip_name
    public_ip_address_id = azurerm_public_ip.example.ip_address_id
  }
}

# Creación del grupo de direcciones de backend del balanceador de carga
resource "azurerm_lb_backend_address_pool" "my_lb_pool" {
  loadbalancer_id = azurerm_lb.my_lb.id
  name            = "test-pool"
}

# Creación de la sonda de salud del balanceador de carga
resource "azurerm_lb_probe" "my_lb_probe" {
  loadbalancer_id     = azurerm_lb.my_lb.id
  name                = "test-probe"
  port                = 80
}

# Creación de la regla del balanceador de carga
resource "azurerm_lb_rule" "my_lb_rule" {
  loadbalancer_id                = azurerm_lb.my_lb.id
  name                           = "test-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  disable_outbound_snat          = true
  frontend_ip_configuration_name = var.public_ip_name
  probe_id                       = azurerm_lb_probe.my_lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.my_lb_pool.id]
}

# Creación de la regla de salida del balanceador de carga
resource "azurerm_lb_outbound_rule" "my_lboutbound_rule" {
  name                    = "test-outbound"
  loadbalancer_id         = azurerm_lb.my_lb.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.my_lb_pool.id

  frontend_ip_configuration {
    name = var.public_ip_name
  }
}

