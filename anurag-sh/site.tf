resource "cloudflare_record" "root" {
  zone_id         = var.cloudflare_zone_id
  name            = "@"
  value           = "76.76.21.21"
  type            = "A"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "og" {
  zone_id         = var.cloudflare_zone_id
  name            = "og"
  value           = "cname.vercel-dns.com"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "www" {
  zone_id         = var.cloudflare_zone_id
  name            = "www"
  value           = "anurag.sh"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "vercel_project" "anurag-sh" {
  name      = "anurag-sh"
  framework = "sveltekit-1"
  git_repository = {
    type = "github"
    repo = "Accurate0/anurag.sh"
  }
}

resource "vercel_project_domain" "anurag-sh-domain" {
  project_id = vercel_project.anurag-sh.id
  domain     = "anurag.sh"
}

resource "vercel_project" "og" {
  name      = "og"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = "Accurate0/vercel-og-nextjs"
  }
}

resource "vercel_project_domain" "og-domain" {
  project_id = vercel_project.og.id
  domain     = "og.anurag.sh"
}
