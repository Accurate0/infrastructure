terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.53.0"
    }
  }
}

provider "aws" {
  region = var.region
  # until ap-southeast-4 is added
  # https://github.com/hashicorp/terraform-provider-aws/pull/29271
  skip_region_validation = true
}

variable "region" {
  type = string
}

variable "role_arn" {
  type = string
}
