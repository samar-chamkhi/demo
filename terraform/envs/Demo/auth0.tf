resource "auth0_tenant" "current_tenant" {
  friendly_name = "Demo"

  session_lifetime = 720
  sandbox_version  = "18"
  enabled_locales  = ["en", "fr"]

  flags {
    allow_legacy_delegation_grant_types = false
    allow_legacy_ro_grant_types         = false
    allow_legacy_tokeninfo_endpoint     = false

    dashboard_insights_view    = true
    dashboard_log_streams_next = true

    enable_apis_section                    = true
    enable_client_connections              = false
    enable_dynamic_client_registration     = false
    enable_pipeline2                       = true
    enable_public_signup_user_exists_error = false
    mfa_show_factor_list_on_enrollment     = true
    revoke_refresh_token_grant             = true
    use_scope_descriptions_for_consent     = true
  }

  session_cookie {
    mode = "persistent"
  }

  sessions {
    oidc_logout_prompt_enabled = false
  }
}

data "auth0_tenant" "current_tenant" {}

data "auth0_resource_server" "auth0_management_api" {
  identifier = "https://${data.auth0_tenant.current_tenant.domain}/api/v2/"
}


resource "auth0_attack_protection" "attack_protection" {
  suspicious_ip_throttling {
    enabled = true
    shields = ["admin_notification", "block"]

    pre_login {
      max_attempts = 100
      rate         = 864000
    }

    pre_user_registration {
      max_attempts = 50
      rate         = 1200
    }
  }


  brute_force_protection {
    enabled      = true
    max_attempts = 5
    mode         = "count_per_identifier_and_ip"
    shields      = ["block", "user_notification"]
  }

  # breached_password_detection {
  #   admin_notification_frequency = ["daily"]
  #   enabled                      = true
  #   method                       = "standard"
  #   shields                      = ["admin_notification", "block"]

  #   pre_user_registration {
  #     shields = ["block"]
  #   }
  # }
}
