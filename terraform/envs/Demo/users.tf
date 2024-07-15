module "auth0_users" {
  source = "../../modules/users"

  # Connection names
  connection_name = "users"
  client1_connection_name = "client1-database"
  client2_connection_name = "client2-database"

  depends_on = [ module.auth0_clients ]

}
