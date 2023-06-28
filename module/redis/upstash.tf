data "upstash_redis_database_data" "this" {
  # change if db recreated
  database_id = data.azurerm_key_vault_secret.upstash-redis-id.value
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
