resource "upstash_redis_database" "this" {
  database_name  = "redis"
  region         = "global"
  primary_region = "ap-southeast-2"
  read_regions   = []
  tls            = true
  auto_scale     = false
  eviction       = true
}
