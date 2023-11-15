resource "fly_machine" "this" {
  for_each   = toset(["syd", "sin"])
  app        = fly_app.this.name
  region     = each.value
  name       = "${fly_app.this.name}-${each.value}"
  image      = "nginx:latest"
  cpus       = 1
  memorymb   = 256
  depends_on = [fly_app.this]
  mounts = [{
    path   = "/data"
    volume = fly_volume.this[each.value].id
  }]

  lifecycle {
    ignore_changes = [image, services, env, name, region, mounts, memorymb, cpus]
  }
}
