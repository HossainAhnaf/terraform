resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = local.vnet_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = local.address_space
}

module "database" {
  source                 = "./modules/database"
  prefix                 = var.prefix
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  virtual_network_name   = azurerm_virtual_network.main.name
  address_prefixes       = local.db_subnet_address_prefix
  server_sku_name        = var.server_sku_name
  database_version       = var.database_version
  database_name          = local.db_name
  virtual_network_id     = azurerm_virtual_network.main.id
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
}

module "backend" {
  source               = "./modules/backend"
  prefix               = var.prefix
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = local.backend_subnet_address_prefix
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
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku_name            = var.frontend_sku_name
  os_type             = var.frontend_os_type
  docker_registry_url = var.docker_registry_url
  docker_image_name   = var.frontend_docker_image_name
}


output "database_name" {
  value = module.database.database_name
}