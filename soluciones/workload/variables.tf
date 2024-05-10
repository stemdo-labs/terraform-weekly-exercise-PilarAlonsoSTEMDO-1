variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "username" {
  type        = string
  default     = "microsoft"
  description = "The username for the local account that will be created on the new VM."
}

variable "password" {
  type        = string
  default     = "Microsoft@123"
  description = "The passoword for the local account that will be created on the new VM."
}

variable "virtual_network_name" {
  type        = string
  default     = "test-vnet"
  description = "Name of the Virtual Network."
}

variable "subnet_name" {
  type        = string
  default     = "test-subnet"
  description = "Name of the subnet."
}

variable "public_ip_name" {
  type        = string
  default     = "test-public-ip"
  description = "Name of the Public IP."
}

variable "network_security_group_name" {
  type        = string
  default     = "test-nsg"
  description = "Name of the Network Security Group."
}

variable "network_interface_name" {
  type        = string
  default     = "test-nic"
  description = "Name of the Network Interface."
}

variable "virtual_machine_name" {
  type        = string
  default     = "test-vm"
  description = "Name of the Virtual Machine."
}

variable "virtual_machine_size" {
  type        = string
  default     = "Standard_B2s"
  description = "Size or SKU of the Virtual Machine."
}

variable "disk_name" {
  type        = string
  default     = "test-disk"
  description = "Name of the OS disk of the Virtual Machine."
}

variable "redundancy_type" {
  type        = string
  default     = "Standard_LRS"
  description = "Storage redundancy type of the OS disk."
}

variable "load_balancer_name" {
  type        = string
  default     = "test-lb"
  description = "Name of the Load Balancer."
}