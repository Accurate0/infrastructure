resource "github_actions_secret" "vercen-project-id" {
  repository      = "maccas-web"
  secret_name     = "VERCEL_PROJECT_ID"
  plaintext_value = vercel_project.maccas-web.id
}
