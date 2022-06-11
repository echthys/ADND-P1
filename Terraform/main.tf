provider "azurerm" {
  features {}

}

module "rg" {
  source   = ".\\Modules\\ResourceGroup"
  name     = "ADND-RG"
  location = "uksouth"
}

module "vnet" {
  source   = ".\\Modules\\Networking\\VirtualNetwork"
  name = "ADND-VNET"
  location = "uksouth"
  resource_group_name = module.rg.name
}

module "snet" {
  source   = ".\\Modules\\Networking\\Subnet"
  name = "ADND-SUBNET"
  location = "uksouth"
  resource_group_name = module.rg.name
  virtual_network_name = module.vnet.VNET.name
  address_prefixes     = ["10.0.1.0/24"]
}


module "nsg" {
  source   = ".\\Modules\\Networking\\NetworkSecurityGroup"
  name = "ADND-SUBNET"
  location = "uksouth"
  resource_group_name = module.rg.name
  subnet_id = module.snet.Subnet.id
}


module "nsr-subnet-access" {
  source   = ".\\Modules\\Networking\\NetworkSecurityRule"
  name                        = "Allow-Subnet-Access"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.1.0/24"
  destination_address_prefix  = "10.0.1.0/24"
  resource_group_name         = module.rg.name
  network_security_group_name = module.nsg.NSG.name
}

module "http-access" {
  source   = ".\\Modules\\Networking\\NetworkSecurityRule"
  name                        = "Allow-HTTP-Access"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.rg.name
  network_security_group_name = module.nsg.NSG.name
}

module "deny-access" {
  source   = ".\\Modules\\Networking\\NetworkSecurityRule"
  name                        = "Deny-Access"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.rg.name
  network_security_group_name = module.nsg.NSG.name
}

module "aset" {
  source = ".\\Modules\\VirtualMachineAvailabilitySet"
  name = "ADND-ASET"
  location = "uksouth"
  resource_group_name = module.rg.name
}


module "nic" {
  source   = ".\\Modules\\Networking\\NetworkInterfaceCard"
  name = "ADND-NIC"
  location = "uksouth"
  resource_group_name = module.rg.name
  subnet_id = module.snet.Subnet.id
  network_security_group_id = module.nsg.NSG.id
}

module "pip" {
  source   = ".\\Modules\\Networking\\PublicIP"
  name = "ADND-PIP"
  location = "uksouth"
  resource_group_name = module.rg.name
}

module "lb" {
  source   = ".\\Modules\\LoadBalancer"
  name = "ADND-LB"
  location = "uksouth"
  resource_group_name = module.rg.name
  public_ip_address_id = module.pip.PIP.id
}

module "vm" {
  source = ".\\Modules\\VirtualMachine"
  count = 2
  managed_image_name = "UbuntuWebServer"
  managed_image_resource_group_name = "packer-rg"
  name = "ADND-VM-${count.index}"
  location = "uksouth"
  subnet_id = module.snet.Subnet.id
  resource_group_name = module.rg.name
  backend_address_pool_id = module.lb.Pool.id
  availability_set_id = module.aset.avail_set.id
  network_security_group_id = module.nsg.NSG.id
}