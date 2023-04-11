terraform {
  required_providers {
    upstash = {
      source  = "upstash/upstash"
      version = "1.3.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "upstash"
    }
  }
}

provider "upstash" {
  api_key = var.UPSTASH_API_KEY
  email   = var.UPSTASH_EMAIL
}

variable "UPSTASH_API_KEY" {
  type = string
}

variable "UPSTASH_EMAIL" {
  type = string
}

data "upstash_redis_database_data" "this" {
  # change if db recreated
  database_id = "d263a12a-8d5d-4338-8c44-ea534d15d4e9"
}

output "connection_string" {
  sensitive = true
  value     = "rediss://:${data.upstash_redis_database_data.this.password}@${data.upstash_redis_database_data.this.endpoint}:${data.upstash_redis_database_data.this.port}"
}

output "password" {
  sensitive = true
  value     = data.upstash_redis_database_data.this.password
}

output "endpoint" {
  sensitive = true
  value     = data.upstash_redis_database_data.this.endpoint
}

output "port" {
  sensitive = true
  value     = data.upstash_redis_database_data.this.port
}
