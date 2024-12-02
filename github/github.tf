locals {
  repos = toset(["spotify-sync"])
}

resource "github_actions_secret" "kubeconfig" {
  for_each        = local.repos
  repository      = each.value
  secret_name     = "KUBE_CONFIG"
  plaintext_value = module.kubeconfig.secret_value
}

resource "github_actions_secret" "argocd-actions-token" {
  for_each        = local.repos
  repository      = each.value
  secret_name     = "ARGOCD_AUTH_TOKEN"
  plaintext_value = module.argocd-actions-token.secret_value
}

