terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "anurag-sh"
    }
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
