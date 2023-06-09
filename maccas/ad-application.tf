resource "azuread_application" "this" {
  device_only_auth_enabled       = false
  display_name                   = "Maccas API"
  fallback_public_client_enabled = true
  group_membership_claims        = []
  identifier_uris = [
    "https://login.anurag.sh/f285a3b9-c589-4fae-971e-edd635df6b96",
  ]
  oauth2_post_response_required = false
  owners = [
    "7b7d9e23-91c7-422a-a326-aab46e28099d",
  ]
  prevent_duplicate_names = false
  sign_in_audience        = "AzureADandPersonalMicrosoftAccount"

  api {
    known_client_applications      = []
    mapped_claims_enabled          = false
    requested_access_token_version = 2

    oauth2_permission_scope {
      admin_consent_description  = "Maccas.ReadWrite"
      admin_consent_display_name = "Maccas.ReadWrite"
      enabled                    = true
      id                         = "66a19fba-3885-40f8-bcd5-2436ad5f6338"
      type                       = "Admin"
      value                      = "Maccas.ReadWrite"
    }
  }

  feature_tags {
    custom_single_sign_on = false
    enterprise            = false
    gallery               = false
    hide                  = false
  }

  public_client {
    redirect_uris = []
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      id   = "37f7f235-527c-4136-accd-4a02d197296e"
      type = "Scope"
    }
    resource_access {
      id   = "7427e0e9-2fba-42fe-b0c0-848c9e6a8182"
      type = "Scope"
    }
  }
  required_resource_access {
    resource_app_id = "f285a3b9-c589-4fae-971e-edd635df6b96"

    resource_access {
      id   = "66a19fba-3885-40f8-bcd5-2436ad5f6338"
      type = "Scope"
    }
  }

  single_page_application {
    redirect_uris = [
      "http://localhost:3000/",
      "http://localhost:3000/login",
      "https://jwt.ms/",
      "https://maccas.one/login",
      "https://maccas.one/",
      "https://dev.maccas.one/login",
      "https://dev.maccas.one/"
    ]
  }

  timeouts {}

  web {
    redirect_uris = []

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }
}
