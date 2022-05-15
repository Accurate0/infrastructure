terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.11.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "maccas-api-v2"
    }
  }
}
provider "azurerm" {
  features {}
}

provider "aws" {}

provider "aws" {
  alias  = "singapore"
  region = "ap-southeast-1"
}
