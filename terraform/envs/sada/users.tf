module "auth0_users" {
  source = "../../modules/users"

  # Connection names
  connection_name = "users"
  client1_connection_name = "client1_database"
  client2_connection_name = "client2_database"

  depends_on = [ module.auth0_clients ]
}
