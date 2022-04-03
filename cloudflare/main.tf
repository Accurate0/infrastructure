terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "cloudflare"
    }
  }
}


provider "cloudflare" {}
provider "azurerm" {
  features {}
}
