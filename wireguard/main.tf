terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.1.0"
    }
  }

  backend "s3" {
    key = "wireguard/terraform.tfstate"
  }
}

provider "aws" {
  default_tags {
    tags = {
      Project = "Wireguard"
    }
  }
}