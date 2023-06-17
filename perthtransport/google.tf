data "google_project" "maps-js" {
  project_id = "perthtransport-js-map"
}

resource "google_apikeys_key" "this" {
  display_name = "Maps JS API Key"
  name         = "maps-js-api-key"
  project      = data.google_project.maps-js.project_id

  restrictions {
    api_targets {
      methods = []
      service = "maps-backend.googleapis.com"
    }

    browser_key_restrictions {
      allowed_referrers = ["https://perthtransport.xyz"]
    }
  }
}

resource "google_project_service" "maps-js-service" {
  project = data.google_project.maps-js.project_id
  service = "maps-backend.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}
