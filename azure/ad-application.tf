resource "azuread_application" "actions" {
  device_only_auth_enabled       = false
  display_name                   = "actions"
  fallback_public_client_enabled = false
  group_membership_claims        = []
  identifier_uris                = []
  oauth2_post_response_required  = false
  owners = [
    "47245261-7eb5-4a37-9d1a-a3805201ddde",
  ]
  prevent_duplicate_names = false
  sign_in_audience        = "AzureADMyOrg"

  api {
    known_client_applications      = []
    mapped_claims_enabled          = false
    requested_access_token_version = 1

    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access actions on behalf of the signed-in user."
      admin_consent_display_name = "Access actions"
      enabled                    = true
      id                         = "7593c8bc-a7ac-47b5-b125-cb45ba8c27a9"
      type                       = "User"
      user_consent_description   = "Allow the application to access actions on your behalf."
      user_consent_display_name  = "Access actions"
      value                      = "user_impersonation"
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
      id   = "1bfefb4e-e0b5-418b-a88f-73c46d2cc8e9"
      type = "Role"
    }
    resource_access {
      id   = "19dbc75e-c2e2-444c-a770-ec69d8559fc7"
      type = "Role"
    }
  }

  single_page_application {
    redirect_uris = []
  }

  timeouts {}

  web {
    redirect_uris = []

    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  }
}

resource "azuread_application" "terraform" {
  device_only_auth_enabled       = false
  display_name                   = "terraform"
  fallback_public_client_enabled = false
  group_membership_claims        = []
  identifier_uris                = []
  oauth2_post_response_required  = false
  owners = [
    "47245261-7eb5-4a37-9d1a-a3805201ddde",
  ]
  prevent_duplicate_names = false
  sign_in_audience        = "AzureADMyOrg"

  api {
    known_client_applications      = []
    mapped_claims_enabled          = false
    requested_access_token_version = 1

    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access terraform on behalf of the signed-in user."
      admin_consent_display_name = "Access terraform"
      enabled                    = true
      id                         = "63165654-08d7-4cdf-9368-3277ecf94ab5"
      type                       = "User"
      user_consent_description   = "Allow the application to access terraform on your behalf."
      user_consent_display_name  = "Access terraform"
      value                      = "user_impersonation"
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
      id   = "1bfefb4e-e0b5-418b-a88f-73c46d2cc8e9"
      type = "Role"
    }
    resource_access {
      id   = "19dbc75e-c2e2-444c-a770-ec69d8559fc7"
      type = "Role"
    }
  }

  single_page_application {
    redirect_uris = []
  }

  timeouts {}

  web {
    redirect_uris = []

    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  }
}

resource "time_rotating" "client_id_expiry" {
  rotation_days = 365
}

resource "azuread_application_password" "terraform-credentials" {
  application_id = azuread_application.terraform.id
  rotate_when_changed = {
    rotation = time_rotating.client_id_expiry.id
  }
}
