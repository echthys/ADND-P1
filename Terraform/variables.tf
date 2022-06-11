variable "prefix" {
  default     = "ADND"
  description = "The name of project"
  type        = string
}

variable "vm_count" {
  default     = 2
  description = "The amount of VMs"
  type        = number
}

variable "location" {
  default     = "UK South"
  description = "The region of the resources to be deployed"
  type        = string
}

variable "managed_image_name" {
  default     = "UbuntuWebServer"
  description = "Name of image created by packer"
  type        = string
}


variable "managed_image_resource_group_name" {
  default     = "packer-rg"
  description = "Resource group that contains image created by packer"
  type        = string
}
