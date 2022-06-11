variable "prefix" {
  default = "ADND"
  description = "The name of project"
  type = string
}

variable "vm_count" {
  default = 2
  description = "The amount of VMs"
  type = number
}

variable "location" {
  default = "UK South"
  description = "The region of the resources to be deployed"
  type = string
}