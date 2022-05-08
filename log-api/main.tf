terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "log-api"
    }
  }
}

provider "azurerm" {
  features {}
}
