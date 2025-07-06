locals {
  server_subnet_name       = "${var.prefix}-server-subnet"
  mysql_server_name        = "${var.prefix}-mysql-flexible-server"
  dns_zone_name            = "privatelink.mysql.database.azure.com"
  dns_zone_link_name       = "server-dns-link"
}
