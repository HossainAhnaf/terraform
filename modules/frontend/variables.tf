variable "extra_naming_suffix" {
  description = "The naming suffix"
  type        = list(string)
}

variable "os_type" {
  description = "The os type"
  type        = string
}
variable "asp_resource_id" {
  description = "The app service plan resource id"
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
