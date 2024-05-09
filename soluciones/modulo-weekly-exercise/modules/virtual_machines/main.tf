resource "azurerm_linux_virtual_machine" "my_vm" {
  count                 = length(var.vm_instances)
  name                  = "${var.virtual_machine_name}${count.index}"
  location              = var.location
  resource_group_name   = var.existent_resource_group_nombre
  network_interface_ids = var.network_interface_ids
  size                  = var.virtual_machine_size

  os_disk {
    name                 = "${var.disk_name}${count.index}"
    caching              = "ReadWrite"
    storage_account_type = var.redundancy_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = var.disable_password_authentication
}
