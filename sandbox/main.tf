terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
  }

  backend "s3" {
    key = "sandbox/terraform.tfstate"
  }
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::932929614071:role/development"
  }
}
