variable "resource_group" {
  description = "El nombre del grupo de recursos."
  type        = string
}

variable "location" {
  description = "La ubicación del recurso."
  type        = string
}

variable "network_security_groups" {
  description = "Configuración de los grupos de seguridad de red y sus asociaciones con subnets."
  type = map(object({
    name = string
    rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
  default = {}
}
