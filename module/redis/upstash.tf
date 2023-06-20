data "upstash_redis_database_data" "this" {
  # change if db recreated
  database_id = "2f3df07f-1e18-460d-9830-e8836b2daff1"
}

output "upstash_connection_string" {
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
