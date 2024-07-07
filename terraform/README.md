# Terraform Directories
This project contains several Terraform modules to automate deployment for an Auth0 Tenant.

## Directories 
### envs 

### modules 
Terraform branding, clints and users modules'.
1. Branding : In this modules we can customize the user login experience, change the client's logo.
2. clients : In this modules we create the different Apps(SPA & DAE, etc), the Connections and the organizations.
3. users : In this modules we create the DAE roles, users for test.  

# Auth0 Terraform Tenant Deployment

This project is a boilerplate for future Lyvoc Demo projects which contains several Terraform modules to automate the deployment of an Auth0 Tenant.

## Getting Started

### Configuration

1. Create a new Auth0 Tenant.

2. Follow the instructions in the [QuickStart guide](https://github.com/auth0/terraform-provider-auth0/blob/main/docs/guides/quickstart.md).

3. Copy the `.env.example` file to `.env` and fill in the required environment variables.

### Installation

1. Install the dependencies:

```bash
cd terraform
terraform init
```

### Usage

1. Plan the deployment:

```bash
terraform plan
```

2. Apply the deployment:

```bash
terraform apply
```

## Resources

- [Auth0 Terraform Provider](https://registry.terraform.io/providers/auth0/auth0/latest/docs)
- [Auth0 Documentation](https://auth0.com/docs/deploy-monitor/auth0-terraform-provider)
- [Auth0 Terraform Examples](https://github.com/auth0/terraform-provider-auth0/tree/main/examples)
