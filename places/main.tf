terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.62.1"
    }

    google = {
      source  = "hashicorp/google"
      version = "4.59.0"
    }
  }

  backend "s3" {
    key = "places/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "google" {
}
