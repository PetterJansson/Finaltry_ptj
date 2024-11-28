terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-backend-ptjlt"
    storage_account_name = "sabemtnlkxdegc"     
    container_name       = "tfstate"                       
    key                  = "backend.terraform.tfstate"        
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

resource "random_string" "random_string" {
  length  = 10
  upper   = false
  special = false
}

resource "azurerm_resource_group" "rg_backend_ptjft" {
  name     = var.rg_backend_ptj_name
  location = var.rg_backend_ptj_location
}

resource "azurerm_storage_account" "sa_backend_ptj" {
  name                     = "${lower(var.sa_backend_ptj)}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.rg_backend_ptjft.name
  location                 = azurerm_resource_group.rg_backend_ptjft.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "sc_backend_ptj" {
    name = var.sc_backend_ptj
    storage_account_name  = azurerm_storage_account.sa_backend_ptj.name
    container_access_type = "private"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv_backend_ptj" {
  name                        = "${lower(var.kv_backend_ptj_name)}${random_string.random_string.result}"
  location                    = azurerm_resource_group.rg_backend_ptjft.location
  resource_group_name         = azurerm_resource_group.rg_backend_ptjft.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create"
    ]

    secret_permissions = [
      "Get", "Set", "List"
    ]

    storage_permissions = [
      "Get", "Set", "List"
    ]
  }
}

resource "azurerm_key_vault_secret" "sa_backend_ptj_accesskey_name" {
  name         = var.sa_backend_ptj_accesskey_name
  value        = azurerm_storage_account.sa_backend_ptj.primary_access_key
  key_vault_id = azurerm_key_vault.kv_backend_ptj.id
}