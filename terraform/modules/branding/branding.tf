# resource "auth0_custom_domain" "tenant_domain" {
#   domain = "auth.example.com"
#   type   = "auth0_managed_certs"
# }

resource "auth0_branding" "brand" {
  # logo_url = "http://localhost:5173/logo.png"

  colors {
    primary         = "#0059d6"
    page_background = "#000000"
  }

  universal_login {
    # Ensure that "{%- auth0:head -%}" and "{%- auth0:widget -%}"
    # are present in the body.
    body = file("universal_login_body.html")
  }
}
