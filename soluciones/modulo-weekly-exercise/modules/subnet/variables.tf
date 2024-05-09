variable "vnet_name" {
  description = "El nombre de la red virtual."
  type        = string
}

variable "resource_group" {
  description = "El nombre del grupo de recursos."
  type        = string
}

variable "subnets" {
  description = "Configuración de las subnets."
  type = map(object({
    name           = string
    address_prefix = string
  }))
  default = {}
}


