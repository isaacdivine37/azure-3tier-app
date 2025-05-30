output "server_fqdn" {
  value = azurerm_postgresql_flexible_server.db.fqdn
}

output "database_name" {
  value = azurerm_postgresql_flexible_server_database.app_db.name
}
