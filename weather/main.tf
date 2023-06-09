terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }

  backend "s3" {
    key = "weather/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {
}