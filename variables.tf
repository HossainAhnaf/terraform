variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "server_sku_name" {
  description = "SKU for MySQL flexible server"
  type        = string
}

variable "database_version" {
  description = "MySQL version"
  type        = string
}

variable "administrator_login" {
  description = "MySQL admin username"
  type        = string
}

variable "administrator_password" {
  description = "MySQL admin password"
  type        = string
  sensitive   = true
}


variable "asp_zone_balancing_enabled" {
  description = "The zone balancing enabled"
  type        = bool
}

variable "asp_rule_based_scale_enabled" {
  description = "The rule based scale enabled"
  type        = bool
}

variable "asp_sku_name" {
  description = "The sku name"
  type        = string
}

variable "asp_os_type" {
  description = "The os type"
  type        = string
}

variable "asp_worker_count" {
  description = "The worker count"
  type        = number
}


variable "frontend_os_type" {
  description = "OS type for frontend App Service Plan"
  type        = string
}


variable "backend_os_type" {
  description = "OS type for backend App Service Plan"
  type        = string
}

variable "docker_registry_url" {
  description = "Docker registry URL"
  type        = string
}

variable "backend_docker_image_name" {
  description = "Docker image for backend App Service"
  type        = string
}
variable "backend_docker_image_tag" {
  description = "Docker image tag for backend App Service"
  type        = string
}

variable "frontend_docker_image_name" {
  description = "Docker image for frontend App Service"
  type        = string
}

variable "frontend_docker_image_tag" {
  description = "Docker image tag for frontend App Service"
  type        = string
}

variable "db_private_dns_zone_name" {
  description = "Private DNS zone name for MySQL flexible server"
  type        = string
}
