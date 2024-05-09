variable "existent_resource_group_nombre" {
  type = string
}

variable "vnet_name" {
  description = "Nombre de la Virtual Network"
  type        = map(string)
  validation {
    condition     = can(regex("^vnet[a-z]{2,}tfexercise\\d{2,}$", var.vnet_name["default"]))
    error_message = "El nombre de la Virtual Network debe seguir el formato especificado."
  }
}

variable "vnet_address_space" {
  description = "Espacio de direcciones de la Virtual Network"
  type        = map(list(string))
}

variable "location" {
  description = "Ubicación donde se desplegará la VNet"
  default     = "West Europe"
  type        = string
}

variable "owner_tag" {
  description = "Propietario de la VNet"
  type        = map(string)
  validation {
    condition     = length(var.owner_tag["default"]) > 0 && var.owner_tag["default"] != null
    error_message = "El valor de owner_tag no puede ser una cadena vacía ni nula."
  }
}

variable "environment_tag" {
  description = "Entorno de la VNet"
  type        = map(string)
  validation {
    condition     = var.environment_tag["default"] != null && var.environment_tag["default"] != "" && contains(["dev", "prod", "test"], lower(var.environment_tag["default"]))
    error_message = "El valor de environment_tag debe ser 'dev', 'prod' o 'test'"
  }
}

variable "vm_instances" {
  description = "Instancias de máquinas virtuales"
  type = list(object({
    vnet_name          = string
    vnet_address_space = list(string)
    location           = string
    owner_tag          = string
    environment_tag    = string
    vnet_tags          = map(string)
  }))
}

variable "vnet_tags" {
  description = "Tags adicionales para la VNet"
  type        = map(string)
  default     = {}
  validation {
    condition     = var.vnet_tags != null && length([for v in values(var.vnet_tags) : v if v == null || v == ""]) == 0
    error_message = "El valor de vnet_tags no puede ser una cadena vacía ni nula."
  }
}
