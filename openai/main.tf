terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.62.1"
    }
  }

  backend "s3" {
    key = "openai/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
