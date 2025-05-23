output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "aks_cluster_fqdn" {
  value = module.aks.cluster_fqdn
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "database_fqdn" {
  value = module.postgresql.server_fqdn
}

output "key_vault_uri" {
  value = module.keyvault.key_vault_uri
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}
