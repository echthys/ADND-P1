terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.10.0"
    }
  }

  required_version = ">= 1.1.0"
}


data "azurerm_image" "customimage" {
  name                = var.managed_image_name
  resource_group_name = var.managed_image_resource_group_name
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "nic_to_nsg" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = var.network_security_group_id
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  #Automatically supports managed disks
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_image.customimage.id
  availability_set_id = var.availability_set_id

}



resource "azurerm_network_interface_backend_address_pool_association" "pool" {
  network_interface_id    = azurerm_network_interface.vm_nic.id 
  ip_configuration_name   = azurerm_network_interface.vm_nic.ip_configuration[0].name
  backend_address_pool_id = var.backend_address_pool_id
}
