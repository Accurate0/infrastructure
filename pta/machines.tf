resource "fly_machine" "redis" {
  app        = fly_app.redis.name
  region     = "syd"
  name       = "pta-redis"
  image      = "redis:alpine"
  cpus       = 1
  memorymb   = 256
  depends_on = [fly_app.redis]

  lifecycle {
    ignore_changes = [image, services, env]
  }
}

resource "fly_machine" "api" {
  app        = fly_app.api.name
  region     = "syd"
  name       = "pta-api"
  image      = "redis:alpine"
  cpus       = 1
  memorymb   = 256
  depends_on = [fly_app.api]

  lifecycle {
    ignore_changes = [image, services, env]
  }
}

resource "fly_machine" "worker" {
  app        = fly_app.worker.name
  region     = "syd"
  name       = "pta-worker"
  image      = "redis:alpine"
  cpus       = 1
  memorymb   = 256
  depends_on = [fly_app.worker]

  lifecycle {
    ignore_changes = [image, services, env]
  }
}
