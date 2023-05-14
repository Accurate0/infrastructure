resource "fly_volume" "this" {
  for_each = toset(["syd", "sin"])
  name     = "redisclustervolume"
  app      = fly_app.this.name
  size     = 1
  region   = each.value
}
