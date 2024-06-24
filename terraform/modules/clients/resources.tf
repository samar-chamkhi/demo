# resource "auth0_resource_server" "spa_api_server" {
#   name       = "${var.project} SPA API Resource Server"
#   identifier = "${var.spa_url}/api"
# }

# resource "auth0_resource_server_scopes" "spa_api_scopes" {
#   resource_server_identifier = auth0_resource_server.spa_api_server.identifier

#   scopes {
#     name        = "read:resources"
#     description = "Ability to read resources"
#   }
# }
