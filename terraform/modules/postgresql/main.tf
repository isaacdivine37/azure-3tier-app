resource "azurerm_postgresql_flexible_server" "db" {
  name                = "${var.prefix}-pgsql"
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "14"

  delegated_subnet_id = var.db_subnet_id
  private_dns_zone_id = azurerm_private_dns_zone.postgres.id

  administrator_login    = var.db_admin_login
  administrator_password = var.db_admin_password

  zone = "1"

  storage_mb = 32768
  sku_name   = "GP_Standard_D2s_v3"

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres]

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "app_db" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.db.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "azurerm_private_dns_zone" "postgres" {
  name                = "${var.prefix}.postgres.database.azure.com"
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = "${var.prefix}-postgres-link"
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group_name

  tags = var.tags
}

resource "azurerm_key_vault_secret" "db_connection_string" {
  name         = "database-connection-string"
  value        = "postgresql://${var.db_admin_login}:${var.db_admin_password}@${azurerm_postgresql_flexible_server.db.fqdn}:5432/${var.database_name}?sslmode=require"
  key_vault_id = var.keyvault_id

  tags = var.tags
}
