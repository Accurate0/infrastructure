resource "fly_ip" "this" {
  app        = fly_app.this.name
  type       = "v4"
  depends_on = [fly_app.this]
}
