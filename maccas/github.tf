module "github-env" {
  source   = "../module/github-environments"
  repo     = "maccas-api"
  branches = ["main", "v2.x"]
  environments = [
    { name = "production" },
  ]
}
