variable "name" {
  type           = string
  description = "Name of subnet"
}
variable "location" {
  type        = string
  description = "Location to create the subnet"
}

variable "resource_group_name" {
  type        = string
  description = "Name of resource group"
}

variable "virtual_network_name" {
  type = string
  description = "Name of virtual network"
}

variable "address_prefixes" {
  type = list(string)
  description = "Address Prefix Size"
}