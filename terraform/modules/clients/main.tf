resource "auth0_client" "tf_provider" {
  name = "Terraform_provider"
}

# Create SPA and SSR clients--------------------------------

resource "auth0_client" "spa_client" {
  name                = "SPA Demo App"
  description         = "SPA Client"
  app_type            = "spa"
  callbacks           = [var.spa_url,"https://demo-sada.eu.auth0.com/login/callback"]
  allowed_logout_urls = [var.spa_url]
  web_origins         = [var.spa_url]

  oidc_conformant               = true
  organization_usage            = "allow"
  organization_require_behavior = "pre_login_prompt"

  jwt_configuration {
    alg = "RS256"
  }
}

resource "auth0_client" "dae_app" {
  name                = "Delegated Admin App"
  description         = "DAE"
  app_type            = "spa"
  # callbacks           = ["${var.dae_url}/login"]
  # "https://demo-sada.eu12.webtask.io/auth0-delegated-admin/login"
  # allowed_logout_urls = [var.dae_url]

  oidc_conformant               = true
  organization_usage            = "allow"
  organization_require_behavior = "pre_login_prompt"

  jwt_configuration {
    alg = "RS256"
  }
}
# resource "auth0_client" "forms_app" {
#   name                = "Auth0 Forms App"
#   description         = "Forms"
#   app_type            = "non_interactive"
#   jwt_configuration {
#     alg = "RS256"
#     scopes = { 
#       "read:users"              = true,
#       "update:users"            = true,
#       "create:users"            = true,
#       "read:users_app_metadata" = true,
#       "update:users_app_metadata" = true,
#       "create:users_app_metadata" = true,
#     }
#   }
  
# }
# Create the Different Connections ----------------------------
# This is an example of an Auth0 connection.

resource "auth0_connection" "users" {
  name                 = "users"
  is_domain_connection = true
  strategy             = "auth0"
  options {
    password_policy                = "excellent"
    brute_force_protection         = true
    enabled_database_customization = false
    import_mode                    = false
    requires_username              = true
    disable_signup                 = false

    password_complexity_options {
      min_length = 8
    }

    validation {
      username {
        min = 6
        max = 40
      }
    }
  }
}

resource "auth0_connection" "client1_database" {
  name                 = "client1-database"
  is_domain_connection = false
  strategy             = "auth0"
  options {
    password_policy                = "excellent"
    brute_force_protection         = true
    enabled_database_customization = false
    import_mode                    = false
    requires_username              = true
    disable_signup                 = false

    password_complexity_options {
      min_length = 8
    }

    validation {
      username {
        min = 6
        max = 40
      }
    }
  }
}

resource "auth0_connection" "client2_database" {
  name                 = "client2-database"
  is_domain_connection = false
  strategy             = "auth0"
  options {
    password_policy                = "excellent"
    brute_force_protection         = true
    enabled_database_customization = false
    import_mode                    = false
    requires_username              = true
    disable_signup                 = false

    password_complexity_options {
      min_length = 8
    }

    validation {
      username {
        min = 6
        max = 40
      }
    }
  }
}
# This is an example of an Okta Workforce connection.

resource "auth0_connection" "okta" {
  name           = "okta-connection"
  display_name   = "Okta Connection"
  strategy       = "okta"
  show_as_button = true

  options {
    client_id                = "0oac2yby19CNiKZMT697"
    client_secret            = "BF2sJ6B2596l3Gqps_K9gojwyFUfyymsdE3dqB6zWklhOCy-C02XpYEAlwANfyei"
    domain                   = "${var.okta_connetion_domain}"
    issuer                   = "https://${var.okta_connetion_domain}"
    jwks_uri                 = "https://${var.okta_connetion_domain}/oauth2/v1/keys"
    token_endpoint           = "https://${var.okta_connetion_domain}oauth2/v1/token"
    userinfo_endpoint        = "https://${var.okta_connetion_domain}/oauth2/v1/userinfo"
    authorization_endpoint   = "https://${var.okta_connetion_domain}/oauth2/v1/authorize"
    scopes                   = ["openid", "email","profile","address","groups"]
    set_user_root_attributes = "on_each_login"
    connection_settings {
      pkce = "disabled"
    }
    attribute_map {
      mapping_mode   = "basic_profile"
      # userinfo_scope = "openid email profile groups"
    }
  }
}

# Connect the clients to the Different connections

resource "auth0_connection_clients" "users_clients_assoc" {
  connection_id = auth0_connection.users.id
  enabled_clients = [
    auth0_client.tf_provider.id,
    auth0_client.spa_client.id,
    auth0_client.dae_app.id
  ]
}

resource "auth0_connection_clients" "client1_clients_assoc" {
  connection_id = auth0_connection.client1_database.id
  enabled_clients = [
    auth0_client.tf_provider.id,
    auth0_client.spa_client.id,
    auth0_client.dae_app.id
    

  ]
}

resource "auth0_connection_clients" "client2_clients_assoc" {
  connection_id = auth0_connection.client2_database.id
  enabled_clients = [
    auth0_client.tf_provider.id,
    auth0_client.spa_client.id,
    auth0_client.dae_app.id
  ]
}
resource "auth0_connection_clients" "okta_clients_assoc" {
  connection_id = auth0_connection.okta.id
  enabled_clients = [
    auth0_client.tf_provider.id,
    auth0_client.spa_client.id
  ]
}

# Create Organizations -----------------------




resource "auth0_organization" "client1" {
  name         = "client1"
  display_name = "Client1"

  branding {
    logo_url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrrNvQapMbdcvr87C4sYW2_nX2nc-FH9377w&s"
    colors = {
      primary         = "#43a2cb"
      page_background = "#b96a6a"
    }
  }
}

resource "auth0_organization_connection" "client1_conn" {
  organization_id            = auth0_organization.client1.id
  connection_id              = auth0_connection.client1_database.id
  assign_membership_on_login = true
}

resource "auth0_organization" "client2" {
  name         = "client2"
  display_name = "Client2"

  branding {
    logo_url = "https://www.tees-personnalises.com/designs/zoom-2-14657023.jpg"
    colors = {
      primary         = "#cd7070"
      page_background = "#477eb8"
    }
  }
}

resource "auth0_organization_connection" "client2_conn" {
  organization_id            = auth0_organization.client2.id
  connection_id              = auth0_connection.client2_database.id
  assign_membership_on_login = true
}
