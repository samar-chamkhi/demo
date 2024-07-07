# Demo
This project is a boilerplate for future Lyvoc Demo projects which contains several Terraform modules to automate the deployment of an Auth0 Tenant.

## Topics covered in the demo : 
- SSO Integration 
- MFA
- SPA Login
- DAE
- Organizations (Login via button)
- Self-service Registration 
- External IDP Login (Okta)

## What does this repository contain
- Terraform Modules Terraform modules to automate the deployment of an Auth0 Tenant.
- React Single Page Web Application: A simple React application that uses Auth0 for authentication with an SPA Client.

## Features 
- Auth0 Tenant: Automate the deployment of an Auth0 Tenant using Terraform.
- Authentication and Registration: Use Auth0 to authenticate and register users.
- Silent Login: Use Auth0 to silently authenticate users .
- Auth0 Actions: Use Auth0 Actions to customize the login and post user registration flows.

## Getting started
### Prerequisites
- [Node.js](https://nodejs.org/en/download/package-manager)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Auth0 Tenant](https://auth0.com/docs/get-started/auth0-overview/create-tenants)

### Installation

1. Clone the repository:

```bash
git clone git@github.com:Lyvoc/spa-okta-cic-auth0.git
```

2. Install the dependencies:

```bash
cd spa-okta-cic-auth0
pnpm install
```

3. Follow the instructions in the `README.md` files in the `src` then `terraform` directories.

## Production

The applications in the `src` directory can be built for a production environment using the following commands:

```bash
pnpm run build
```

The deployment is managed by Github Actions and the applications are deployed to Cloudflare Pages and Cloudflare Workers.
## Project Structure

The repository is organized as follows:

- **`terraform`**: Terraform modules to automate the deployment of an Auth0 Tenant.
- **`src`**: Javascript application that use Auth0 for authentin cation.

Note: Terraform resources include the following users.

| Email                                 | Password       | Role                |
| ------------------------------------- | -------------- | --------------------|
| delegated.admin@yopmail.com           | passpass$12$12 | Dae Delegated admin |
| auditor@yopmail.com                   | passpass$12$12 | Dae Auditor         |
| it.admin@yopmail.com                  | passpass$12$12 | It Admin            |
| admin.client@yopmail.com              | passpass$12$12 | Client Admin        |
| client1.user@yopmail.com              | passpass$12$12 | user of client1     |
| user1@yopmail.com                     | passpass$12$12 | User                |

## Resources 
- [Auth0 Documentation](https://auth0.com/docs)
- [Auth0 Provider](https://registry.terraform.io/providers/auth0/auth0/latest/docs)