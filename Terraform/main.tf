provider "azurerm" {
  features {}

}

module "rg" {
  source   = ".\\Modules\\ResourceGroup"
  name     = "${var.prefix}-RG"
  location = var.location
  project = var.project
}

module "vnet" {
  source   = ".\\Modules\\Networking\\VirtualNetwork"
  name = "${var.prefix}-VNET"
  location = var.location
  resource_group_name = module.rg.name
  project = var.project
}

module "snet" {
  source   = ".\\Modules\\Networking\\Subnet"
  name = "${var.prefix}-SUBNET"
  location = var.location
  resource_group_name = module.rg.name
  virtual_network_name = module.vnet.VNET.name
  address_prefixes     = ["10.0.1.0/24"]
}


module "nsg" {
  source   = ".\\Modules\\Networking\\NetworkSecurityGroup"
  name = "${var.prefix}-SUBNET"
  location = var.location
  resource_group_name = module.rg.name
  subnet_id = module.snet.Subnet.id
  project = var.project
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
  project = var.project
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
  project = var.project
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
  project = var.project
}

module "aset" {
  source = ".\\Modules\\VirtualMachineAvailabilitySet"
  name = "${var.prefix}-ASET"
  location = var.location
  resource_group_name = module.rg.name
  project = var.project
}


module "nic" {
  source   = ".\\Modules\\Networking\\NetworkInterfaceCard"
  name = "${var.prefix}-NIC"
  location = var.location
  resource_group_name = module.rg.name
  subnet_id = module.snet.Subnet.id
  network_security_group_id = module.nsg.NSG.id
  project = var.project
}

module "pip" {
  source   = ".\\Modules\\Networking\\PublicIP"
  name = "${var.prefix}-PIP"
  location = var.location
  resource_group_name = module.rg.name
  project = var.project
}

module "lb" {
  source   = ".\\Modules\\LoadBalancer"
  name = "${var.prefix}-LB"
  location = var.location
  resource_group_name = module.rg.name
  public_ip_address_id = module.pip.PIP.id
  project = var.project
}

module "vm" {
  source = ".\\Modules\\VirtualMachine"
  count = var.vm_count
  managed_image_name = var.managed_image_name
  managed_image_resource_group_name = var.managed_image_resource_group_name
  name = "${var.prefix}-VM-${count.index}"
  location = var.location
  subnet_id = module.snet.Subnet.id
  resource_group_name = module.rg.name
  backend_address_pool_id = module.lb.Pool.id
  availability_set_id = module.aset.avail_set.id
  network_security_group_id = module.nsg.NSG.id
  project = var.project
}