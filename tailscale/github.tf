locals {
  repos = toset(["maccas-api", "spotify-sync"])
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
