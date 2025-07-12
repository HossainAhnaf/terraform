
output "server_fqdn" {
  value       = azurerm_mysql_flexible_server.main.fqdn
  description = "The FQDN of the server"
}

output "database_name" {
  value       = azurerm_mysql_flexible_database.main.name
  description = "The name of the database"
}
