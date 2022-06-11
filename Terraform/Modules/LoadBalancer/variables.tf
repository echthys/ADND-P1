variable "location" {
  type        = string
  description = "The region the of the load balancer will be created in."
}

variable "name" {
  type        = string
  description = "The name of the load balancer to be created."
}

variable "resource_group_name" {
    type = string
    description = "Resource Group for load balancer"
} 

variable "public_ip_address_id" {
  type = string
  description = "ID of PIP to be associated with Load Balancer"
}

variable "project" {
  type = string
  description = "Name of project"
}