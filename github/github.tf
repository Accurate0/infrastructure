locals {
  repos = toset([
    "spotify-sync",
    "replybot",
    "tldr-bot",
    "ozb",
    "maccas-api",
    "perth-transport-map",
    "infrastructure",
    "anurag.sh",
    "pg-db-controller",
  ])
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

resource "github_actions_secret" "tailscale-client-id" {
  for_each        = local.repos
  repository      = each.value
  secret_name     = "TS_OAUTH_CLIENT_ID"
  plaintext_value = module.tailscale-client-id.secret_value
}

resource "github_actions_secret" "tailscale-client-secret" {
  for_each        = local.repos
  repository      = each.value
  secret_name     = "TS_OAUTH_SECRET"
  plaintext_value = module.tailscale-client-secret.secret_value
}
