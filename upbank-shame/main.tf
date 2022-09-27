terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.28.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "upbank-shame"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {}
