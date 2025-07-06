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
variable "virtual_network_id" {
  description = "The virtual network id"
}
variable "address_prefixes" {
  description = "The address prefixes"
  type = list(string)  
  }

variable "server_sku_name" {
  description = "The sku name"
}

variable "database_version" {
  description = "mysql database_version"
}

variable "administrator_login" {
  description = "The mysql administrator login"
}
variable "administrator_password" {
  description = "The mysql administrator password"
}

variable "database_name" {
  description = "The mysql database name"
}

variable "charset" {
  description = "The mysql charset"
  default = "utf8mb4"
}
variable "collation" {
  description = "The mysql collation"
  default = "utf8mb4_unicode_ci"
}