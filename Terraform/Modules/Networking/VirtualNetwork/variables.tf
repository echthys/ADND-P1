variable "name" {
  type           = string
  description = "Name of virtual network"
}
variable "location" {
  type        = string
  description = "Location to create the virtual network"
}

variable "resource_group_name" {
  type        = string
  description = "Name of resource group"
}

variable "project" {
  type = string
  description = "Name of project"
}