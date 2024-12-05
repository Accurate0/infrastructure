resource "github_actions_secret" "maps-api-key" {
  repository      = "perth-transport-map"
  secret_name     = "VITE_MAPS_API_KEY"
  plaintext_value = google_apikeys_key.this.key_string
}
