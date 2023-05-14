output "cluster_connection_string" {
  sensitive = true
  value     = "redis://default:${data.azurerm_key_vault_secret.redis-cluster-password.value}@redis.anurag.sh:6379"
}

output "cluster_stackexchange_connection_string" {
  sensitive = true
  value     = "redis.anurag.sh:6379,ssl=false,password=${data.azurerm_key_vault_secret.redis-cluster-password.value}"
}
