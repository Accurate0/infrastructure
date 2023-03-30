terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "4.59.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "places-api"
    }
  }
}

provider "azurerm" {
  features {}
}


provider "google" {
  project = "axiomatic-grove-348612"
}
