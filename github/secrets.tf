module "kubeconfig" {
  source      = "../module/keyvault-value-output"
  secret_name = "kubeconfig"
}

module "argocd-actions-token" {
  source      = "../module/keyvault-value-output"
  secret_name = "argocd-actions-token"
}

module "tailscale-client-id" {
  source      = "../module/keyvault-value-output"
  secret_name = "tailscale-client-id"
}

module "tailscale-client-secret" {
  source      = "../module/keyvault-value-output"
  secret_name = "tailscale-client-secret"
}
