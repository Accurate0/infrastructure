terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.66.0"
    }
  }

  backend "s3" {
    key = "openai/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
