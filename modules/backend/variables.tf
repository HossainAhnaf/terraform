variable "prefix" {
  description = "The prefix used for all resources" 
}

variable "location" {
 description = "The location/region where the resources are created."
}

variable "resource_group_name" {
  description = "The resource group name"
}

variable "virtual_network_name" {
  description = "The virtual network name"
}
variable "address_prefixes" {
  description = "The address prefixes"
  type = list(string)  
  }

variable "sku_name" {
  description = "The sku name"
}

variable "os_type" {
  description = "The os type"
}


variable "docker_registry_url" {
  description = "The docker registry url"
}

variable "docker_image_name" {
  description = "The docker image name"
}

variable "app_settings" {
  type = map(string)
  description = "The app settings"
}