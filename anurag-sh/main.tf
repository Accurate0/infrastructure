terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 3"
    }
    vercel = {
      source  = "vercel/vercel"
      version = ">= 1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4"
    }
  }

  backend "s3" {
    key = "anurag-sh/terraform.tfstate"
  }
}

variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
  default   = "ccdf653cce6321100fecab81f8f2d9ff"
}

provider "aws" {}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

provider "azurerm" {
  features {}
}
