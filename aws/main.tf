terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.29.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.9.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
  }

  backend "s3" {
    key = "aws/terraform.tfstate"
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
