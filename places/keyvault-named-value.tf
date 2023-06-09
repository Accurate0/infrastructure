module "google-places-api-key" {
  source       = "../module/keyvault-named-value"
  named_value  = "GooglePlacesApiKey"
  secret_name  = "google-places-api-key"
  secret_value = google_apikeys_key.this.key_string
}
