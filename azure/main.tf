terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.63.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.9.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.39.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.29.0"
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
