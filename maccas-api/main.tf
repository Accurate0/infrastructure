terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "maccas-api"
    }
  }
}
provider "azurerm" {
  features {}
}

provider "aws" {}
