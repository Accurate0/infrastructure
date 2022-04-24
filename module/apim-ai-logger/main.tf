terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "api_name" {
  type = string
}

variable "apim_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "ai_name" {
  type = string
}
