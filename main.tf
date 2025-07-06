module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
  suffix = ["hossain", "devops"]
}

resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = local.rg_name
  address_space       = local.address_space
}

module "database" {  
  source                 = "./modules/database"
  prefix                 = var.prefix
  location               = var.location
  resource_group_name    = local.rg_name
  virtual_network_name   = local.vnet_name
  address_prefixes       = local.db_subnet
  server_sku_name        = var.server_sku_name
  database_version       = var.database_version
  database_name          = module.naming.resource_group.name #local.db_name
  virtual_network_id     = azurerm_virtual_network.main.id
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
}

module "backend" {
  source               = "./modules/backend"
  prefix               = var.prefix
  location             = var.location
  resource_group_name  = local.rg_name
  virtual_network_name = local.vnet_name
  address_prefixes     = local.backend_subnet
  sku_name             = var.backend_sku_name
  os_type              = var.backend_os_type
  docker_registry_url  = var.docker_registry_url
  docker_image_name    = var.backend_docker_image_name
  app_settings = {
    SPRING_DATASOURCE_URL      = "jdbc:mysql://${module.database.server_fqdn}:3306/${module.database.database_name}?allowPublicKeyRetrieval=true&useSSL=true&createDatabaseIfNotExist=true&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Europe/Paris"
    SPRING_DATASOURCE_USERNAME = var.administrator_login
    SPRING_DATASOURCE_PASSWORD = var.administrator_password
    SERVER_PORT                = "80"
  }
}

module "frontend" {
  source              = "./modules/frontend"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = local.rg_name
  sku_name            = var.frontend_sku_name
  os_type             = var.frontend_os_type
  docker_registry_url = var.docker_registry_url
  docker_image_name   = var.frontend_docker_image_name
}


output "database_name" {
  value = module.database.database_name
  
}