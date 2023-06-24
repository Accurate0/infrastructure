terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.49.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.8.0"
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
