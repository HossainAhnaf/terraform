variable "extra_naming_suffix" {
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
variable "virtual_network_id" {
  description = "The virtual network id"
  type        = string
}
variable "address_prefixes" {
  description = "The address prefixes"
  type        = list(string)
}

variable "server_sku_name" {
  description = "The sku name"
  type        = string
}

variable "server_storage" {
  description = "The server storage"
  type = object({
    size_gb            = number
    auto_grow_enabled  = bool
    io_scaling_enabled = bool
  })
}
variable "database_version" {
  description = "mysql database_version"
  type        = string
}

variable "administrator_login" {
  description = "The mysql administrator login"
  type        = string
}
variable "administrator_password" {
  description = "The mysql administrator password"
  type        = string
}

variable "charset" {
  description = "The mysql charset"
  default     = "utf8mb4"
  type        = string
}
variable "collation" {
  description = "The mysql collation"
  default     = "utf8mb4_unicode_ci"
  type        = string
}

variable "private_dns_zone_name" {
  description = "The private dns zone name"
  type        = string

}
