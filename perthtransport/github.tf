resource "github_actions_secret" "vercel-project-id" {
  repository      = "perth-transport-map"
  secret_name     = "VERCEL_PROJECT_ID"
  plaintext_value = vercel_project.perthtransport.id
}

resource "github_actions_secret" "vercel-org-id" {
  repository      = "perth-transport-map"
  secret_name     = "VERCEL_ORG_ID"
  plaintext_value = module.vercel-org-id.secret_value
}
