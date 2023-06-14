resource "vercel_project" "perthtransport" {
  name                       = "perthtransport-web"
  framework                  = "nextjs"
  root_directory             = "perthtransport-web"
  serverless_function_region = "syd1"
  git_repository = {
    type = "github"
    repo = "Accurate0/perth-transport-map"
  }
}

resource "vercel_project_domain" "web-domain" {
  project_id = vercel_project.perthtransport.id
  domain     = "perthtransport.xyz"
}
