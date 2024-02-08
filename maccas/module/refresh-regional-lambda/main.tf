terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
}

variable "region" {
  type = string
}

variable "role_arn" {
  type = string
}

output "lambda_arn" {
  value = aws_lambda_function.api.arn
}
