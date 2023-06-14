resource "vercel_project" "perthtransport" {
  name           = "perthtransport"
  framework      = "nextjs"
  root_directory = "perthtransport-web"
  git_repository = {
    type = "github"
    repo = "Accurate0/perth-transport-map"
  }
}

resource "vercel_project_domain" "web-domain" {
  project_id = vercel_project.perthtransport.id
  domain     = "perthtransport.xyz"
}
