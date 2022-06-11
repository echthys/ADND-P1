variable "name" {
    type = string
    description = "Name of Network Security Group"
} 

variable "location" {
    type = string
    description = "Location of Network Security Group"
} 

variable "resource_group_name" {
    type = string
    description = "Resource Group for Network Security Group"
} 

variable "subnet_id" {
  type = string
  description = "Subnet ID for NSG association"
}