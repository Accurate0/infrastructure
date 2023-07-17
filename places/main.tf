terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.63.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "4.73.1"
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
