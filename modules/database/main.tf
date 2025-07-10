# tuaa tuaang

resource "azurerm_subnet" "server_subnet" {
  name                 = local.server_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

  delegation {
    name = "mysqlDelegation"
    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}




resource "azurerm_private_dns_zone" "server" {
  name                = local.dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "server" {
  name                  = local.dns_zone_link_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.server.name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = false
}


resource "azurerm_mysql_flexible_server" "main" {
  name                   = local.mysql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.database_version
  sku_name               = var.server_sku_name
  delegated_subnet_id    = azurerm_subnet.server_subnet.id
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  private_dns_zone_id    = azurerm_private_dns_zone.server.id
  depends_on             = [azurerm_private_dns_zone_virtual_network_link.server]
}

resource "azurerm_mysql_flexible_database" "main" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.main.name
  charset             = var.charset
  collation           = var.collation
}
