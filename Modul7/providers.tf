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
    key                  = "rg.terraform.tfstate"
  }
}


provider "azurerm" {
  subscription_id = "efc1e7b1-5729-4eea-b33e-12cc6b1c0183"
  features {}
}