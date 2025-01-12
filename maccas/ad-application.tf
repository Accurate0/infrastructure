data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_application" "this" {
  provider                       = azuread.adb2c
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
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph

    resource_access {
      id   = "37f7f235-527c-4136-accd-4a02d197296e" # offline_access
      type = "Scope"
    }
    resource_access {
      id   = "7427e0e9-2fba-42fe-b0c0-848c9e6a8182" # openid
      type = "Scope"
    }

    # ADB2C user access... not sure what is what...
    resource_access {
      id   = "09850681-111b-4a89-9bed-3f2cae46d706"
      type = "Role"
    }

    resource_access {
      id   = "741f803b-c850-494e-b5df-cde7c675a1ca"
      type = "Role"
    }

    resource_access {
      id   = "df021288-bdef-4463-88db-98f22de89214"
      type = "Role"
    }

    resource_access {
      id   = "405a51b5-8d8d-430b-9842-8be4b0e9f324"
      type = "Role"
    }

    resource_access {
      id   = "7ab1d382-f21e-4acd-a863-ba3e13f7da61"
      type = "Role"
    }

    resource_access {
      id   = "19dbc75e-c2e2-444c-a770-ec69d8559fc7"
      type = "Role"
    }

    resource_access {
      id   = "c529cfca-c91b-489c-af2b-d92990b66ce6"
      type = "Role"
    }

    resource_access {
      id   = "f20584af-9290-4153-9280-ff8bb2c0ea7f"
      type = "Role"
    }
  }

  required_resource_access {
    resource_app_id = "f285a3b9-c589-4fae-971e-edd635df6b96" # Maccas API

    resource_access {
      id   = "66a19fba-3885-40f8-bcd5-2436ad5f6338" # Maccas.ReadWrite
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

resource "time_rotating" "client_id_expiry" {
  rotation_days = 365
}

# client secret for graph api
resource "azuread_application_password" "this" {
  provider          = azuread.adb2c
  application_id    = azuread_application.this.object_id
  end_date_relative = "8760h"

  rotate_when_changed = {
    rotation = time_rotating.client_id_expiry.id
  }
}
