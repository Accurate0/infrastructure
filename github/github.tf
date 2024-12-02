locals {
  repos = toset(["spotify-sync"])
}

resource "github_actions_secret" "kubeconfig" {
  for_each        = local.repos
  repository      = each.value
  secret_name     = "KUBE_CONFIG"
  plaintext_value = module.kubeconfig.secret_value
}

