terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
}

variable "api_name" {
  type = string
}

variable "lambda_runtime" {
  type = string
}

variable "lambda_handler" {
  type = string
}

variable "api_routes" {
  type = list(object({ route = string, method = string }))
}

variable "api_version" {
  type = string
}

output "http_endpoint" {
  value     = aws_api_gateway_stage.api-stage.invoke_url
  sensitive = true
}

output "api_key" {
  value     = aws_api_gateway_api_key.api-key.value
  sensitive = true
}
