terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.11.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.3.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "aws"
    }
  }
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
