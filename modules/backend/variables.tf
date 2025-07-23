
variable "naming_suffix" {
  description = "The naming suffix"
  type        = list(string)
}

variable "location" {
  description = "The location/region where the resources are created."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "virtual_network_name" {
  description = "The virtual network name"
  type        = string
}
variable "address_prefixes" {
  description = "The address prefixes"
  type        = list(string)
}

variable "sku_name" {
  description = "The sku name"
  type        = string
}

variable "os_type" {
  description = "The os type"
  type        = string
}

variable "worker_count" {
  description = "The worker count"
  type        = number
}

variable "docker_registry_url" {
  description = "The docker registry url"
  type        = string
}

variable "docker_image_name" {
  description = "The docker image name"
  type        = string
}

variable "docker_image_tag" {
  description = "The docker image tag"
  type        = string
}

variable "app_settings" {
  type        = map(string)
  description = "The app settings"
}
