variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "db_admin_login" {
  description = "Database administrator login"
  type        = string
  sensitive   = true
}

variable "db_admin_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Name of the application database"
  type        = string
  default     = "appdb"
}

variable "keyvault_id" {
  description = "Key Vault ID for storing secrets"
  type        = string
}

variable "db_subnet_id" {
  description = "Subnet ID for database"
  type        = string
}

variable "vnet_id" {
  description = "Virtual Network ID"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
