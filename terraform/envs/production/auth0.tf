resource "auth0_tenant" "current_tenant" {
  friendly_name = "Auth0 Demo"

  session_lifetime = 8760
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

# resource "auth0_connection" "lyvoc_organization_connection_samlp" {
#   name           = "Lyvoc-Organization-SAML-Connection"
#   display_name   = "Lyvoc SAML Connection"
#   strategy       = "samlp"
#   show_as_button = true

#   # TODO: Pass secret data from a secret stored data store
#   options {
#     # signing_cert        = "<signing-certificate>"
#     sign_in_endpoint    = "https://demo-lyvoc.eu.auth0.com/samlp/cIClZBawBDhtShv5KjCvpwLkJP2MXzuS"
#     sign_out_endpoint   = "https://demo-lyvoc.eu.auth0.com/samlp/cIClZBawBDhtShv5KjCvpwLkJP2MXzuS/logout"
#     disable_sign_out    = true
#     tenant_domain       = "demo-lyvoc.eu.auth0.com"
#     domain_aliases      = ["lyvoc.com"]
#     protocol_binding    = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
#     request_template    = "<samlp:AuthnRequest xmlns:samlp=\"urn:oasis:names:tc:SAML:2.0:protocol\"\n@@AssertServiceURLAndDestination@@\n    ID=\"@@ID@@\"\n    IssueInstant=\"@@IssueInstant@@\"\n    ProtocolBinding=\"@@ProtocolBinding@@\" Version=\"2.0\">\n    <saml:Issuer xmlns:saml=\"urn:oasis:names:tc:SAML:2.0:assertion\">@@Issuer@@</saml:Issuer>\n</samlp:AuthnRequest>"
#     user_id_attribute   = "https://saml.provider/imi/ns/identity-200810"
#     signature_algorithm = "rsa-sha256"
#     digest_algorithm    = "sha256"
#     metadata_url        = "https://demo-lyvoc.eu.auth0.com/samlp/metadata/cIClZBawBDhtShv5KjCvpwLkJP2MXzuS"
#     debug               = false

#     # fields_map = jsonencode({
#     #   "name" : ["name", "nameidentifier"]
#     #   "email" : ["emailaddress", "nameidentifier"]
#     #   "family_name" : "surname"
#     # })
#   }
# }

# resource "auth0_connection_clients" "saml_client_assoc" {
#   connection_id = auth0_connection.database.id
#   enabled_clients = [
#     auth0_client.spa_local.id,
#     auth0_client.spa_cloudflare_page.id
#   ]
# }

# resource "auth0_connection_clients" "oidc_client_assoc" {
#   connection_id = auth0_connection.database.id
#   enabled_clients = [
#     auth0_client.spa_local.id,
#     auth0_client.spa_cloudflare_page.id
#   ]
# }

resource "auth0_role" "user_role" {
  name        = "User Role"
  description = "Default user role"
}

# resource "auth0_role_permissions" "user_role_permissions" {
#   role_id = auth0_role.user_role.id

#   permissions {
#     name                       = "read:resources"
#     resource_server_identifier = auth0_resource_server.spa_api_local_server.identifier
#   }

#   permissions {
#     name                       = "read:resources"
#     resource_server_identifier = auth0_resource_server.spa_api_cloudflare_server.identifier
#   }
# }

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

  breached_password_detection {
    admin_notification_frequency = ["daily"]
    enabled                      = true
    method                       = "standard"
    shields                      = ["admin_notification", "block"]

    pre_user_registration {
      shields = ["block"]
    }
  }
}

resource "auth0_prompt" "prompt" {
  universal_login_experience     = "new"
  identifier_first               = true
  webauthn_platform_first_factor = false
}

resource "auth0_log_stream" "log_webhook" {
  name = "HTTP Webhook.site log stream"
  type = "http"

  sink {
    http_endpoint       = "https://webhook.site/8aafefd0-5ccd-4a4d-a6b4-83c033858352"
    http_content_type   = "application/json"
    http_content_format = "JSONOBJECT"
  }
}

resource "auth0_client" "assign_role_action_client" {
  name        = "Assign Role Action Client"
  description = "Auth0 Assign role Action client"
  app_type    = "non_interactive"

  jwt_configuration {
    alg = "RS256"
  }
}

resource "auth0_client_grant" "assign_role_action_client_grant" {
  client_id = auth0_client.assign_role_action_client.id
  audience  = data.auth0_resource_server.auth0_management_api.identifier
  scopes = [
    "read:roles",
    "update:users",
    "read:role_members",
    "create:role_members",
  ]
}

resource "auth0_client_credentials" "assign_role_action_client_credentials" {
  client_id = auth0_client.assign_role_action_client.id

  authentication_method = "client_secret_post"
}

resource "auth0_action" "assign_default_role" {
  name    = "Assign default role for every user"
  runtime = "node18"
  deploy  = true
  code    = <<-EOT
    const { ManagementClient } = require("auth0");

    exports.onExecutePostLogin = async (event) => {
      if (Array.isArray(event.authorization?.roles) && event.authorization.roles.includes('user')) {
        return;
      }

      const management = new ManagementClient({
        domain: event.secrets.domain,
        clientId: event.secrets.clientId,
        clientSecret: event.secrets.clientSecret,
      });

      try {
        const roles = [event.secrets.defaultRoleId];
        await management.users.assignRoles(
          { id: event.user.user_id },
          { roles }
        );
      } catch (e) {
        console.log(e);
      }
    };
	EOT

  # We prefer using post-login because we are social connection.
  # Social connection does not trigger registration
  supported_triggers {
    id      = "post-login"
    version = "v3"
  }

  dependencies {
    name    = "auth0"
    version = "latest"
  }

  secrets {
    name  = "domain"
    value = data.auth0_tenant.current_tenant.domain
  }

  secrets {
    name  = "defaultRoleId"
    value = auth0_role.user_role.id
  }

  secrets {
    name  = "clientId"
    value = auth0_client.assign_role_action_client.client_id
  }

  secrets {
    name  = "clientSecret"
    value = auth0_client_credentials.assign_role_action_client_credentials.client_secret
  }

  depends_on = [
    auth0_role.user_role,
    auth0_client.assign_role_action_client,
    auth0_client_credentials.assign_role_action_client_credentials
  ]
}

resource "auth0_trigger_action" "post_user_login_remember_mfa_action" {
  trigger   = "post-login"
  action_id = auth0_action.remember_mfa_action.id

  depends_on = [auth0_action.remember_mfa_action]
}

resource "auth0_action" "remember_mfa_action" {
  name    = "Remember Browser MFA"
  runtime = "node18"
  deploy  = true
  code    = <<-EOT
    exports.onExecutePostLogin = async (event, api) => {
      const authMethods = event.authentication?.methods || [];
      const completedMfa = !!authMethods.find((method) => method.name === 'mfa');

      if (!completedMfa) {
        api.multifactor.enable('any', { allowRememberBrowser: true });
      }
    };
	EOT

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }
}

resource "auth0_trigger_action" "post_user_login_assign_default_role_action" {
  trigger   = "post-login"
  action_id = auth0_action.assign_default_role.id

  depends_on = [auth0_action.assign_default_role]
}

resource "auth0_action" "add_custom_claims_action" {
  name    = "Enrich Id Token custom claims"
  runtime = "node18"
  deploy  = true
  code    = <<-EOT
    exports.onExecutePostLogin = async (event, api) => {
      const namespace = event.secrets.domain;

      if (typeof event.request?.geoip === 'object') {
        const { countryCode } = event.request.geoip;

        api.idToken.setCustomClaim(namespace + '/countryCode', countryCode);
      }

      if (typeof event.authorization === 'object') {
        const { roles } = event.authorization;

        api.idToken.setCustomClaim(namespace + '/roles', roles);
        api.accessToken.setCustomClaim(namespace + '/roles', roles);
      }
    };
	EOT

  secrets {
    name  = "domain"
    value = data.auth0_tenant.current_tenant.domain
  }

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }

  depends_on = [auth0_tenant.current_tenant]
}

resource "auth0_trigger_action" "post_user_login_add_custom_claims_action" {
  trigger   = "post-login"
  action_id = auth0_action.add_custom_claims_action.id

  depends_on = [auth0_action.add_custom_claims_action]
}

resource "auth0_action" "registration_alert" {
  name    = "Notify an external system"
  runtime = "node18"
  deploy  = true
  code    = <<-EOT
    const axios = require("axios");

    exports.onExecutePostUserRegistration = async (event) => {
      // await axios.post("https://my-api.exampleco.com/users", { params: { email: event.user.email }});
    };
	EOT

  supported_triggers {
    id      = "post-user-registration"
    version = "v2"
  }
}

resource "auth0_trigger_action" "post_user_registration_alert_action" {
  trigger   = "post-user-registration"
  action_id = auth0_action.registration_alert.id
}

# Import Users resources

resource "auth0_connection" "migration_database" {
  name     = "migration-database"
  strategy = "auth0"

  options {
    password_policy        = "good"
    brute_force_protection = true
    requires_username      = false
    disable_signup         = true

    password_history {
      enable = true
      size   = 2
    }

    mfa {
      active                 = true
      return_enroll_settings = true
    }
  }
}

# resource "auth0_connection_client" "spa_local_migration_database_client_assoc" {
#   connection_id = auth0_connection.migration_database.id
#   client_id     = auth0_client.spa_local.id
# }

resource "auth0_client" "import_users_client" {
  name        = "Users Import Client"
  description = "Users Import script or Curl Client"
  app_type    = "non_interactive"

  jwt_configuration {
    alg = "RS256"
  }
}

resource "auth0_client_grant" "import_users_client_grant" {
  client_id = auth0_client.import_users_client.id
  audience  = data.auth0_resource_server.auth0_management_api.identifier
  scopes = [
    "read:connections",
    "create:users",
  ]
}

resource "auth0_client_credentials" "import_users_client_credentials" {
  client_id = auth0_client.import_users_client.id

  authentication_method = "client_secret_post"
}
