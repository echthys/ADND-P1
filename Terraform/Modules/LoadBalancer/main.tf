terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.10.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}


resource "azurerm_lb" "lb" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = var.public_ip_address_id
  }
  sku = "Basic"
  tags = {
    "Environment" = var.project
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackendPool"
}

resource "azurerm_lb_rule" "lbrule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "Port80"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80 
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  backend_address_pool_ids = azurerm_lb_backend_address_pool.lb_backend.*.id
}