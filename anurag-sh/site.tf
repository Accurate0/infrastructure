resource "cloudflare_record" "root" {
  zone_id         = var.cloudflare_zone_id
  name            = "@"
  value           = "76.76.21.21"
  type            = "A"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

resource "vercel_project" "anurag-sh" {
  name      = "anurag-sh"
  framework = "create-react-app"
  git_repository = {
    type = "github"
    repo = "Accurate0/anurag.sh"
  }
}

resource "vercel_project_domain" "anurag-sh-domain" {
  project_id = vercel_project.anurag-sh.id
  domain     = "anurag.sh"
}
