terraform {
  required_providers {
    binarylane = {
      source  = "oscarhermoso/binarylane"
      version = "~>0.8"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~>4"
    }
  }

  backend "s3" {
    key = "k8s/terraform.tfstate"
  }
}

provider "binarylane" {}
provider "azurerm" {
  features {}
}

