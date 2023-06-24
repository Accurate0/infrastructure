terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.62.1"
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

  backend "s3" {
    key = "azure/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}
