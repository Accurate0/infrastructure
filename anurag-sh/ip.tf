module "home-ip-kv" {
  source      = "../module/keyvault-value-output"
  secret_name = "home-static-ip"
}
