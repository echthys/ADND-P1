variable "name" {
  type        = string
  description = "Name of Network Security Rule"
}

variable "priority" {
  type        = number
  description = "Priority of Network Security Rule"
}

variable "direction" {
  type        = string
  description = "Direction of Network Security Rule"
}

variable "access" {
  type        = string
  description = "Allow or Deny on Network Security Rule"
}

variable "protocol" {
  type        = string
  description = "Network Protocol for Network Security Rule"
}

variable "source_port_range" {
  type        = string
  description = "Source port for Network Security Rule"
}

variable "destination_port_range" {
  type        = string
  description = "Destination port for Network Security Rule"
}

variable "source_address_prefix" {
  type        = string
  description = "Source Address prefix for Network Security Rule"

}

variable "destination_address_prefix" {
  type        = string
  description = "Destination Address Prefix for Network Security Rule"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "network_security_group_name" {
  type        = string
  description = "Name of security group to attach the Network Security Rule"
}
