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

variable "api_runtime" {
  type = string
}

variable "api_handler" {
  type = string
}

variable "api_routes" {
  type = list(string)
}

output "http_endpoint" {
  value     = "${aws_apigatewayv2_api.apigwv2.api_endpoint}/${aws_apigatewayv2_api.apigwv2.name}"
  sensitive = true
}
