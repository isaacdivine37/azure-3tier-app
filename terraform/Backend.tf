terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "maziuzochukwu1234"
    storage_account_name = "Maziisaac1234"  # Replace with your storage account name
    container_name       = "maziuzochukwu"
    key                  = "prod.terraform.tfstate"
  }
}