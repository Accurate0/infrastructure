terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
    github = {
      source  = "integrations/github"
      version = "5.29.0"
    }
  }

  backend "s3" {
    key = "statuspage/terraform.tfstate"
  }
}

provider "aws" {
  default_tags {
    tags = {
      Project = "statuspage"
    }
  }
}
