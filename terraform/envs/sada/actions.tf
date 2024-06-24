# resource "auth0_action" "action1" {
#   name    = "Create_role_attribute"
#   runtime = "node18"
#   deploy  = true
#   code    = <<-EOT
#         exports.onExecutePostLogin = async (event, api) => {
#             const userRoles = event.authorization.roles;
#             api.user.setAppMetadata('roles', userRoles);
#         };
#   EOT
#   supported_triggers {
#     id      = "post-login"
#     version = "v3"
#   }
# }

# # console.log(`Successfully updated app_metadata.roles for user ${event.user.user_id}`);

# resource "auth0_action" "action2" {
#   name    = "Add Custom claim to the ID Token"
#   runtime = "node18"
#   deploy  = true
#   code    = <<-EOT
#         exports.onExecutePostLogin = async (event, api) => {
#             const departement = event.user.user_metadata.departement 
#             api.idToken.setCustomClaim("departement",departement)
#         };
#   EOT
#   supported_triggers {
#     id      = "post-login"
#     version = "v3"
#   }
# }

# resource "auth0_action" "action3" {
#   name = "mfa_Trigger"
#   runtime = "node18"
#   deploy  = true
#   code    = <<-EOT
#         exports.onExecutePostLogin = async (event, api) => {
#             const userEmail = "sada.user1@yopmail.com"
#             if (event.user.name === userEmail) {
#                 api.multifactor.enable('any', { allowRememberBrowser: true })
#             }

#             if (event.client.name === 'Delegated Administration Dashboard' && event.user.nickname === "delegated.admin.sada") {
#                 console.log("event", event);
#                 api.multifactor.enable('any', { allowRememberBrowser: true })
#             }
#      };
#   EOT
#   supported_triggers {
#     id      = "post-login"
#     version = "v3"
#   }
# }
# resource "auth0_action" "action4" {
#   name = "dae_action"
#   runtime = "node18"
#   deploy  = true
#   code    = <<-EOT
#         exports.onExecutePostLogin = async (event, api) => {  
#             console.log("dae event", event)
#             const namespace = `https://demo-sada/auth0-delegated-admin`;
#             api.idToken.setCustomClaim(namespace, { "roles": event.authorization.roles })
#         };
#   EOT
#   supported_triggers {
#     id      = "post-login"
#     version = "v3"
#   }
# }

# resource "auth0_action" "progressive_profiling" {
#   name = "progressive_profiling"
#   runtime = "node18"
#   deploy  = true
#   code    = <<-EOT
#         exports.onExecutePostLogin = async (event, api) => {  
#               api.redirect.sendUserTo(`form://${var.form_id}}`, {
#                 query: { context_token: contextToken }
#               });
#         };
#   EOT
#   supported_triggers {
#     id      = "post-login"
#     version = "v3"
#   }
# }


# resource "auth0_trigger_actions" "login_flow" {
#   trigger= "post-login"
#   actions {
#     id      = auth0_action.action1.id
#     display_name =   auth0_action.action1.name
#   }
#   actions {
#     id      = auth0_action.action2.id
#     display_name =   auth0_action.action2.name
#   }
#   # actions {
#   #   id      = auth0_action.progressive_profiling.id
#   #   display_name =   auth0_action.progressive_profiling.name
#   # }
#   actions {
#     id      = auth0_action.action4.id
#     display_name =   auth0_action.action4.name
#   }
# }