resource "vercel_project_environment_variable" "prod-url" {
  project_id = vercel_project.maccas-web.id
  key        = "NEXT_PUBLIC_API_BASE"
  value      = "https://api.maccas.one/v1"
  target     = ["production"]
}

resource "vercel_project_environment_variable" "dev-url" {
  project_id = vercel_project.maccas-web.id
  key        = "NEXT_PUBLIC_API_BASE"
  value      = "https://api.dev.maccas.one/v1"
  target     = ["preview"]
}
