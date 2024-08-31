module "home-ip" {
  source      = "../module/keyvault-value-output"
  secret_name = "home-static-ip"
}
