#!/bin/bash

# Variables
RESOURCE_GROUP="maziuzochukwu1234"
STORAGE_ACCOUNT="Maziisaac1234"
CONTAINER_NAME="maziuzochukwu"
LOCATION="westus"

echo "Creating Terraform state storage..."

# Create resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create storage account
az storage account create \
  --resource-group $RESOURCE_GROUP \
  --name $STORAGE_ACCOUNT \
  --sku Standard_LRS \
  --encryption-services blob

# Create storage container
az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT

echo "Setup complete!"
echo "Storage Account: $STORAGE_ACCOUNT"
echo "Update your backend.tf with these values"