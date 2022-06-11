variable "managed_image_name" {
   description = "Name of the Virtual Machine"
}
variable "managed_image_resource_group_name" {
   description = "Name of the Virtual Machine resource group"
}

variable "location" {
  type        = string
  description = "The region the of the Virtual Machine will be created in."
}

variable "name" {
  type        = string
  description = "The name of the Virtual Machine to be created."
}

variable "resource_group_name" {
    type = string
    description = "Resource Group for Virtual Machine"
} 

variable "subnet_id" {
  type = string
  description = "Subnet the VM goes in"
}

variable "backend_address_pool_id" {
  type = string
  description = "Backend Address Pool of Load Balancer"
}

variable "availability_set_id" {
  type = string
  description = "Availability Set ID"
}

variable "network_security_group_id" {
  type        = string
  description = "Network Security Group"
}

variable "project" {
  type = string
  description = "Name of project"
}