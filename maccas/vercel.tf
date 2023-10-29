resource "vercel_project_environment_variable" "prod-url-v2" {
  project_id = vercel_project.maccas-web-v2.id
  key        = "VITE_API_BASE"
  value      = "https://api.maccas.one/v1"
  target     = ["production"]
}
resource "vercel_project_environment_variable" "dev-url" {
  project_id = vercel_project.maccas-web-v2.id
  key        = "VITE_API_BASE"
  value      = "https://api.dev.maccas.one/v1"
  target     = ["preview"]
}

resource "vercel_project_domain" "base" {
  project_id = vercel_project.maccas-web-v2.id
  domain     = "maccas-web-v2.vercel.app"

  redirect             = vercel_project_domain.maccas-one-web-domain.domain
  redirect_status_code = 308
}
