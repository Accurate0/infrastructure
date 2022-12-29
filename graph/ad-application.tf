resource "azuread_application" "this" {
  device_only_auth_enabled       = false
  display_name                   = "Graph API"
  fallback_public_client_enabled = false
  group_membership_claims        = []
  identifier_uris                = []
  oauth2_post_response_required  = false
  owners = [
    "7b7d9e23-91c7-422a-a326-aab46e28099d",
  ]
  prevent_duplicate_names = false
  sign_in_audience        = "AzureADandPersonalMicrosoftAccount"

  api {
    known_client_applications      = []
    mapped_claims_enabled          = false
    requested_access_token_version = 2
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
      id   = "7427e0e9-2fba-42fe-b0c0-848c9e6a8182"
      type = "Scope"
    }
    resource_access {
      id   = "37f7f235-527c-4136-accd-4a02d197296e"
      type = "Scope"
    }
    resource_access {
      id   = "97235f07-e226-4f63-ace3-39588e11d3a1"
      type = "Role"
    }
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

  single_page_application {
    redirect_uris = []
  }

  timeouts {}

  web {
    redirect_uris = [
      "https://oauth.pstmn.io/v1/browser-callback",
    ]

    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = false
    }
  }
}
