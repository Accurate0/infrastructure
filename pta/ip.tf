resource "fly_ip" "api" {
  app        = fly_app.api.name
  type       = "v4"
  depends_on = [fly_app.api]
}
