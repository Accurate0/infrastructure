terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.1.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "vpn"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Project = "VPN"
    }
  }
}
