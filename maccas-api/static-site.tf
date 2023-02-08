variable "cloudflare_zone_id_maccas_one" {
  type      = string
  sensitive = true
  default   = "7104890048c02e9a312f6ebbc8a8359a"
}

resource "vercel_project" "maccas-web" {
  name      = "maccas-web"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = "Accurate0/maccas-web"
  }
}

resource "vercel_project_domain" "maccas-one-web-domain" {
  project_id = vercel_project.maccas-web.id
  domain     = "maccas.one"
}
