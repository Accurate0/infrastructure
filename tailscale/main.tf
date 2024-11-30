terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~>5"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4"
    }
  }

  backend "s3" {
    key = "tailscale/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
