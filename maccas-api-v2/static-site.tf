resource "cloudflare_record" "maccas" {
  zone_id         = var.cloudflare_zone_id
  name            = "maccas"
  value           = "cname.vercel-dns.com"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
}

resource "vercel_project" "maccas-web" {
  name      = "maccas-web"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = "Accurate0/maccas-web"
  }
}

resource "vercel_project_domain" "maccas-web-domain" {
  project_id = vercel_project.maccas-web.id
  domain     = "maccas.anurag.sh"
}
