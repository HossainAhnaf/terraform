module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=75d5afa"
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
  source                          = "./modules/database"
  location                        = azurerm_resource_group.main.location
  resource_group_name             = azurerm_resource_group.main.name
  server_sku_name                 = var.server_sku_name
  database_version                = var.database_version
  database_name                   = module.naming.mysql_database.name
  administrator_login             = var.administrator_login
  administrator_password          = var.administrator_password
  virtual_network_name            = azurerm_virtual_network.main.name
  virtual_network_id              = azurerm_virtual_network.main.id
  address_prefixes                = local.db_subnet_address_prefix
  server_subnet_name              = module.naming.subnet.name
  private_link_service_name       = module.naming.private_link_service.name
  private_dns_zone_name           = module.naming.private_dns_zone.name
  private_dns_zone_group_name     = module.naming.private_dns_zone_group.name
  private_service_connection_name = module.naming.private_service_connection.name
  private_endpoint_name           = module.naming.private_endpoint.name
  mysql_server_name               = module.naming.mysql_server.name
}

module "backend" {
  source               = "./modules/backend"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = local.backend_subnet_address_prefix
  backend_plan_name    = module.naming.app_service_plan.name
  backend_webapp_name  = module.naming.app_service.name
  backend_subnet_name  = module.naming.subnet.name
  sku_name             = var.backend_sku_name
  os_type              = var.backend_os_type
  worker_count         = var.backend_worker_count
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
  source               = "./modules/frontend"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  frontend_plan_name   = module.naming.app_service_plan.name
  frontend_webapp_name = module.naming.app_service.name
  sku_name             = var.frontend_sku_name
  os_type              = var.frontend_os_type
  worker_count         = var.frontend_worker_count
  docker_registry_url  = var.docker_registry_url
  docker_image_name    = var.frontend_docker_image_name
  docker_image_tag     = var.frontend_docker_image_tag
}
