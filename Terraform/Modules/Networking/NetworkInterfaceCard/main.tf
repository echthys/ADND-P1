terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.10.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_network_interface" "nic" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    "Environment" = var.project
  }
}

resource "azurerm_network_interface_security_group_association" "nic_to_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.network_security_group_id
}