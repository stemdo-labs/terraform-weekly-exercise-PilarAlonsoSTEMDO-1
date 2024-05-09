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



variable "vnet_tags" {
  description = "Tags adicionales para la VNet"
  type        = map(string)
  default     = {}
  validation {
    condition     = var.vnet_tags != null && length([for v in values(var.vnet_tags) : v if v == null || v == ""]) == 0
    error_message = "El valor de vnet_tags no puede ser una cadena vacía ni nula."
  }
}
variable "subnets" {
  description = "Configuración de las subnets."
  type = map(object({
    name           = string
    address_prefix = string
  }))
  default = {}
}

variable "network_interface_name" {
  description = "Nombre de la interfaz de red"
  type        = string
}

variable "virtual_machine_name" {
  description = "Nombre de la máquina virtual"
  type        = string
}

variable "virtual_machine_size" {
  description = "Tamaño de la máquina virtual"
  type        = string
}

variable "disk_name" {
  description = "Nombre del disco"
  type        = string
}

variable "redundancy_type" {
  description = "Tipo de redundancia para el disco"
  type        = string
}



variable "load_balancer_name" {
  description = "Nombre del balanceador de carga"
  type        = string
}




variable "public_ip_name" {
  description = "Nombre de la IP pública"
  type        = string
}
variable "network_interface_ids" {
  description = "Lista de IDs de las interfaces de red asociadas a la máquina virtual"
  type        = list(string)
}

variable "vm_instances" {
  description = "Instancias de máquinas virtuales"
  type = list(object({
    location              = string
    resource_group_name   = string
    network_interface_ids = list(string)
    virtual_machine_size  = string
    disk_name             = string
    redundancy_type       = string
    admin_username        = string
    admin_password        = string
    disable_password_authentication = bool
  }))
}
variable "username" {
  description = "Nombre de usuario para la máquina virtual"
  type        = string
}

variable "password" {
  description = "Contraseña para la máquina virtual"
  type        = string
}
variable "disable_password_authentication" {
  description = "Indica si se debe deshabilitar la autenticación por contraseña en la máquina virtual"
  type        = bool
}