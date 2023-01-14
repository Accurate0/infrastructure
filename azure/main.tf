terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.32.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.3.0"
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

provider "azuread" {}
