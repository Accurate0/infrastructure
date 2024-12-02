module "kubeconfig" {
  source      = "../module/keyvault-value-output"
  secret_name = "kubeconfig"
}

