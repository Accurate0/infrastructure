module "kubeconfig" {
  source      = "../module/keyvault-value-output"
  secret_name = "kubeconfig"
}

module "argocd-actions-token" {
  source      = "../module/keyvault-value-output"
  secret_name = "argocd-actions-token"
}

