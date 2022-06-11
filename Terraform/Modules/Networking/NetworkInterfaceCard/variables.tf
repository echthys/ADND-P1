variable "subnet_id" {
  type        = string
  description = "Subnet ID for the NIC"
}

variable "name" {
  type        = string
  description = "Name of NIC"
}

variable "location" {
  type        = string
  description = "Location of NIC"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group for NIC"
}

variable "network_security_group_id" {
  type        = string
  description = "Network Security Group"
}
