module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=75d5afa" #https://xhamster.desi/videos/gorgeous-teen-deepthroating-13274965
  suffix = local.suffix
}

resource "azurerm_resource_group" "main" {
  name     = module.naming.resource_group.name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = module.naming.virtual_network.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = local.address_space
}

module "database" {
  source                 = "./modules/database"
  extra_naming_suffix    = local.suffix
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  server_sku_name        = var.server_sku_name
  server_storage         = var.server_storage
  database_version       = var.database_version
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  virtual_network_name   = azurerm_virtual_network.main.name
  virtual_network_id     = azurerm_virtual_network.main.id
  address_prefixes       = local.db_subnet_address_prefix
  private_dns_zone_name  = var.db_private_dns_zone_name
}

module "asp" {
  source                   = "./modules/asp"
  naming_suffix            = local.suffix
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  os_type                  = var.asp_os_type
  sku_name                 = var.asp_sku_name
  worker_count             = var.asp_worker_count
  zone_balancing_enabled   = var.asp_zone_balancing_enabled
  rule_based_scale_enabled = var.asp_rule_based_scale_enabled
}

module "backend" {
  source               = "./modules/backend"
  extra_naming_suffix  = local.suffix
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = local.backend_subnet_address_prefix
  os_type              = var.backend_os_type
  asp_resource_id      = module.asp.resource_id
  docker_registry_url  = var.docker_registry_url
  docker_image_name    = var.backend_docker_image_name
  docker_image_tag     = var.backend_docker_image_tag
  app_settings = {
    SPRING_DATASOURCE_URL      = "jdbc:mysql://${module.database.server_fqdn}:3306/${module.database.database_name}?allowPublicKeyRetrieval=true&useSSL=true&createDatabaseIfNotExist=true&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Europe/Paris"
    SPRING_DATASOURCE_USERNAME = var.administrator_login
    SPRING_DATASOURCE_PASSWORD = var.administrator_password
  }
  depends_on = [module.database]
}

module "frontend" {
  source              = "./modules/frontend"
  extra_naming_suffix = local.suffix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = var.frontend_os_type
  asp_resource_id     = module.asp.resource_id

  docker_registry_url = var.docker_registry_url
  docker_image_name   = var.frontend_docker_image_name
  docker_image_tag    = var.frontend_docker_image_tag
}
