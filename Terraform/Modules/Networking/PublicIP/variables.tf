variable "name" {
  type           = string
  description = "Name of PIP"
}
variable "location" {
  type        = string
  description = "Location to create the PIP"
}

variable "resource_group_name" {
  type        = string
  description = "Name of resource group"
}

variable "project" {
  type = string
  description = "Name of project"
}