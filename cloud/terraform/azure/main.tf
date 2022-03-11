terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "azure"
    }
  }
}

provider "azurerm" {
  features {}
}
