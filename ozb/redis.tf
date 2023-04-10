variable "UPSTASH_API_KEY" {
  type = string
}

variable "UPSTASH_EMAIL" {
  type = string
}

module "redis" {
  source          = "../module/redis"
  UPSTASH_API_KEY = var.UPSTASH_API_KEY
  UPSTASH_EMAIL   = var.UPSTASH_EMAIL
}
