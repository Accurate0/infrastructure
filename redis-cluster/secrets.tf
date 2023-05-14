resource "random_password" "redis-password" {
  length  = 50
  special = false
}

module "redis-password" {
  source       = "../module/keyvault-value"
  secret_name  = "redis-cluster-password"
  secret_value = random_password.redis-password.result
}
