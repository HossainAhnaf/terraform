# tuaa tuaang
resource "azurerm_subnet" "server_subnet" {
  name                 = var.server_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

}

resource "azurerm_private_dns_zone" "server" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "server" {
  name                  = var.private_link_service_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.server.name
  virtual_network_id    = var.virtual_network_id
}


resource "azurerm_mysql_flexible_server" "main" {
  name                         = var.mysql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.database_version
  sku_name                     = var.server_sku_name
  administrator_login          = var.administrator_login
  administrator_password       = var.administrator_password
  private_dns_zone_id          = azurerm_private_dns_zone.server.id
  geo_redundant_backup_enabled = true
  public_network_access        = "Disabled"
  depends_on                   = [azurerm_private_dns_zone_virtual_network_link.server]
}

resource "azurerm_mysql_flexible_database" "main" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.main.name
  charset             = var.charset
  collation           = var.collation
}

resource "azurerm_private_endpoint" "mysql_pe" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.server_subnet.id

  private_dns_zone_group {
    name                 = var.private_dns_zone_group_name
    private_dns_zone_ids = [azurerm_private_dns_zone.server.id]
  }

  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = azurerm_mysql_flexible_server.main.id
    subresource_names              = ["mysqlServer"] # For MySQL Flexible Server
    is_manual_connection           = false
  }
}
