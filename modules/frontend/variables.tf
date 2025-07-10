variable "prefix" {
  description = "The prefix used for all resources"
  type        = string
}

variable "location" {
  description = "The location/region where the resources are created."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "sku_name" {
  description = "The sku name"
  type        = string
}

variable "os_type" {
  description = "The os type"
  type        = string
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
