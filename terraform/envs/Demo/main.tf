terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = ">= 1.0.0" # Refer to docs for latest version
    }
  }
}

provider "auth0" {
  domain        = "my-tenant-1.eu.auth0.com"
  client_id     = "raJ96jKh99RonuvzSLvt1jwpHuOy4g11"
  client_secret = "t5mIOfoQpoeAWAjWpYbpLDzF5tx77JeUjb1ZUwMEiWLWLVRObz5yoiT8ljo2Vgj3"

}
resource "auth0_client" "tf_provider" {
  name = "Terraform_provider"
}