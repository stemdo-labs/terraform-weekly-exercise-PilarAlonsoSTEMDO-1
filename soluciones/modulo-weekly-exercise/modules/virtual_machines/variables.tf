variable "vm_instances" {
  description = "Instancias de máquinas virtuales"
  type = list(object({
    location                        = string
    resource_group_name             = string
    network_interface_ids           = list(string)
    virtual_machine_size            = string
    disk_name                       = string
    redundancy_type                 = string
    admin_username                  = string
    admin_password                  = string
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
variable "existent_resource_group_nombre" {
  type = string
}

variable "location" {
  description = "Ubicación donde se desplegará la VNet"
  default     = "West Europe"
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


variable "network_interface_ids" {
  description = "Lista de IDs de las interfaces de red asociadas a la máquina virtual"
  type        = list(string)
}