
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

variable "database_name" {
  description = "The mysql database name"
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

variable "private_endpoint_name" {
  description = "The private endpoint name"
  type        = string
}
variable "private_dns_zone_group_name" {
  description = "The private dns zone group name"
  type        = string
}
variable "private_service_connection_name" {
  description = "The private service connection name"
  type        = string
}

variable "server_subnet_name" {
  description = "The server subnet name"
  type        = string

}

variable "private_link_service_name" {
  description = "The private link service name"
  type        = string
}

variable "private_dns_zone_name" {
  description = "The private dns zone name"
  type        = string
}
variable "mysql_server_name" {
  description = "The mysql server name"
  type        = string

}
