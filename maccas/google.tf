data "google_project" "places" {
  project_id = "maccas-places-api"
}

resource "google_apikeys_key" "this" {
  display_name = "Places API Key"
  name         = "places-api-key"
  project      = data.google_project.places.project_id

  restrictions {
    api_targets {
      methods = []
      service = "places-backend.googleapis.com"
    }

    api_targets {
      methods = []
      service = "places.googleapis.com"
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

resource "google_project_service" "places-new-service" {
  project = data.google_project.places.project_id
  service = "places.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}
