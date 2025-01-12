terraform {
  required_providers {
    binarylane = {
      source  = "oscarhermoso/binarylane"
      version = "~> 0.9"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4"
    }
  }

  backend "s3" {
    key = "binarylane/terraform.tfstate"
  }
}

provider "binarylane" {}
provider "azurerm" {
  features {}
}


# anurag.sh
variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
  default   = "ccdf653cce6321100fecab81f8f2d9ff"
}
