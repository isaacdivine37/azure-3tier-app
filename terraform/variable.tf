variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "azure-3tier-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "west US"
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "app3tier"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
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

  validation {
    condition     = length(var.db_admin_password) >= 8
    error_message = "Database password must be at least 8 characters long."
  }
}
