resource "fly_app" "redis" {
  name = "pta-redis"
  org  = "pta"
}

resource "fly_app" "api" {
  name = "pta-api"
  org  = "pta"
}

resource "fly_app" "worker" {
  name = "pta-worker"
  org  = "pta"
}
