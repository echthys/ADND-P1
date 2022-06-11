variable "location" {
  type        = string
  description = "The region the of the availabilty set will be created in."
}

variable "name" {
  type        = string
  description = "The name of the availabilty set to be created."
}

variable "resource_group_name" {
    type = string
    description = "Resource Group for availabilty set"
} 

variable "project" {
  type = string
  description = "Name of project"
}