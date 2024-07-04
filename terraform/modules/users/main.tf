# Create Diffrent Users -------------------------------
resource "auth0_user" "dae_delegated_admin" {
  connection_name = var.connection_name
  username        = "dae_delegated_admin"
  email           = "delegated.admin@yopmail.com"
  email_verified  = true
  password        = "passpass$12$12"
  # lifecycle {
  #   ignore_changes = [roles]
  # }
}
resource "auth0_user" "dae_auditor" {
  connection_name = var.connection_name
  username        = "dae_auditor"
  email           = "auditor@yopmail.com"
  email_verified  = true
  password        = "passpass$12$12"
  # lifecycle {
  #   ignore_changes = [roles]
  # }
}
resource "auth0_user" "it_admin" {
  connection_name = var.connection_name
  username        = "it_admin"
  email           = "it.admin@yopmail.com"
  email_verified  = true
  password        = "passpass$12$12"
  # lifecycle {
  #   ignore_changes = [roles]
  # }
}
resource "auth0_user" "hr_admin" {
  connection_name = var.connection_name
  username        = "hr_admin"
  email           = "hr.admin@yopmail.com"
  email_verified  = true
  password        = "passpass$12$12"
  # lifecycle {
  #   ignore_changes = [roles]
  # }
}
resource "auth0_user" "finance_admin" {
  connection_name = var.connection_name
  username        = "finance_admin"
  email           = "finance.admin@yopmail.com"
  email_verified  = true
  password        = "passpass$12$12"
  # lifecycle {
  #   ignore_changes = [roles]
  # }
}
resource "auth0_user" "client1_admin" {
  connection_name = var.client1_connection_name
  username        = "admin_client1"
  email           = "admin.client@yopmail.com"
  email_verified  = true
  password        = "passpass$12$12"
  # lifecycle {
  #   ignore_changes = [roles]
  # }
}
resource "auth0_user" "client2_admin" {
  connection_name = var.client2_connection_name
  username        = "admin_client2"
  email           = "admin.client2@yopmail.com"
  email_verified  = true
  password        = "passpass$12$12"
  # lifecycle {
  #   ignore_changes = [roles]
  # }
}
resource "auth0_user" "user1" {
  connection_name = var.connection_name
  username        = "user1"
  email           = "user1@yopmail.com"
  email_verified  = true
  password        = "passpass$12$12"
  # lifecycle { 
  #   ignore_changes = [roles]
  # }
}
resource "auth0_user" "client" {
  connection_name = var.client1_connection_name
  username        = "client"
  email           = "client@yopmail.com"
  email_verified  = true
  password        = "passpass$12$12"
  # lifecycle { 
  #   ignore_changes = [roles]
  # }
}
resource "auth0_user" "client2_user" {
  connection_name = var.client2_connection_name
  username        = "client2_user"
  email           = "client2.user@yopmail.com"
  email_verified  = true
  password        = "passpass$12$12"
  # lifecycle { 
  #   ignore_changes = [roles]
  # }
}

# Create the Different Roles ------------------------------

resource "auth0_role" "dae_delegated_admin" {
  name        = "Delegated Admin - Administrator"
  description = "Do everything that the Delegated Admin- User can, plus see all logs in the tenant and configure Hooks."
}

resource "auth0_role" "dae_operator" {
  name        = "Delegated Admin - Operator"
  description = "Access user management and logs, but not the extension configuration section."
}

resource "auth0_role" "dae_user" {
  name        = "Delegated Admin - User"
  description = "Search for users, create users, open users, and execute actions on users (such as delete or block)."
}

resource "auth0_role" "dae_auditor" {
  name        = "Delegated Admin - Auditor"
  description = "Search for users and view user information, but not make changes. Action-based buttons are not visible to this role."
}
resource "auth0_role" "client1_admin" {
  name        = "client1 Admin"
  description = "Administrator of our client 1"
}
resource "auth0_role" "client2_admin" {
  name        = "client2 Admin"
  description = "Administrator of our client 2"
}
resource "auth0_role" "finance_admin" {
  name        = "Finance Admin"
  description = "Administrator of finance department"
}
resource "auth0_role" "hr_admin" {
  name        = "HR Admin"
  description = "Administrator - HR department"
}
resource "auth0_role" "it_admin" {
  name        = "IT Admin"
  description = "	Administrator - IT department"
}

# Assign the Roles to the Users------------------------------
resource "auth0_user_roles" "dae_delegated_admin_roles" {
  user_id = auth0_user.dae_delegated_admin.id
  roles   = [auth0_role.dae_delegated_admin.id]
}

resource "auth0_user_roles" "dae_auditor_roles" {
  user_id = auth0_user.dae_auditor.id
  roles   = [auth0_role.dae_auditor.id]
}
resource "auth0_user_roles" "it_admin_roles" {
  user_id = auth0_user.it_admin.id
  roles   = [auth0_role.it_admin.id, auth0_role.dae_operator.id]
}

resource "auth0_user_roles" "hr_admin_roles" {
  user_id = auth0_user.hr_admin.id
  roles   = [auth0_role.hr_admin.id, auth0_role.dae_operator.id]
}

resource "auth0_user_roles" "finance_admin_roles" {
  user_id = auth0_user.finance_admin.id
  roles   = [auth0_role.finance_admin.id, auth0_role.dae_operator.id]
}
resource "auth0_user_roles" "client1_admin_roles" {
  user_id = auth0_user.client1_admin.id
  roles   = [auth0_role.client1_admin.id, auth0_role.dae_operator.id]
}
resource "auth0_user_roles" "client2_admin_roles" {
  user_id = auth0_user.client2_admin.id
  roles   = [auth0_role.client2_admin.id, auth0_role.dae_operator.id]
}




