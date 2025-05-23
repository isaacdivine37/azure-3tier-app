provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = local.common_tags
}

module "networking" {
  source = "./modules/networking"

  prefix              = var.prefix
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  tags                = local.common_tags
}

module "keyvault" {
  source = "./modules/keyvault"

  prefix              = var.prefix
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  tags                = local.common_tags
}

module "postgresql" {
  source = "./modules/postgresql"

  prefix              = var.prefix
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  db_admin_login      = var.db_admin_login
  db_admin_password   = var.db_admin_password
  keyvault_id         = module.keyvault.key_vault_id
  db_subnet_id        = module.networking.db_subnet_id
  vnet_id             = module.networking.vnet_id
  tags                = local.common_tags
}

module "aks" {
  source = "./modules/aks"

  prefix              = var.prefix
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  aks_subnet_id       = module.networking.aks_subnet_id
  keyvault_id         = module.keyvault.key_vault_id
  tags                = local.common_tags
}

module "acr" {
  source = "./modules/acr"

  prefix              = var.prefix
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  aks_principal_id    = module.aks.principal_id
  tags                = local.common_tags
}

locals {
  common_tags = {
    Environment = var.environment
    Project     = "Azure3TierApp"
    ManagedBy   = "Terraform"
  }
}
