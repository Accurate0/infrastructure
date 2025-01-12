terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2"
    }
    github = {
      source  = "integrations/github"
      version = "~>5"
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
