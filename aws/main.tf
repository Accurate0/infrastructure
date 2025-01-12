terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5"
    }
    github = {
      source  = "integrations/github"
      version = "~>5"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4"
    }
    time = {
      source  = "hashicorp/time"
      version = "~>0.9"
    }
  }

  backend "s3" {
    key = "aws/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {
  default_tags {
    tags = {
      Project = "Shared Resource"
    }
  }
}

# anurag.sh
variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
  default   = "ccdf653cce6321100fecab81f8f2d9ff"
}
