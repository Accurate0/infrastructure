resource "google_project" "places" {
  name       = "Places"
  project_id = "axiomatic-grove-348612"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_apikeys_key" "this" {
  display_name = "Maps API Key"
  name         = "ca8b400f-56c1-43aa-9b34-563fbec0ae46"
  project      = google_project.places.project_id

  restrictions {
    api_targets {
      methods = []
      service = "places-backend.googleapis.com"
    }
  }
}
