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

resource "azurerm_availability_set" "availabilty_set" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count = 2
  tags = {
    "Environment" = var.project
  }
}