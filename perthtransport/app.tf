resource "fly_app" "redis" {
  name = "perthtransport-redis"
  org  = "pta"
}

resource "fly_app" "api" {
  name = "perthtransport-api"
  org  = "pta"
}

resource "fly_app" "worker" {
  name = "perthtransport-worker"
  org  = "pta"
}
