data "google_project" "places" {
  project_id = "places-proxy-api"
}

resource "google_apikeys_key" "this" {
  display_name = "Maps API Key"
  name         = "maps-api-key"
  project      = data.google_project.places.project_id

  restrictions {
    api_targets {
      methods = []
      service = "places-backend.googleapis.com"
    }
  }
}

resource "google_project_service" "places-service" {
  project = data.google_project.places.project_id
  service = "places-backend.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}
