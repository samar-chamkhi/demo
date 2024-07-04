# Terraform Directories
This project contains several Terraform modules to automate deployment for an Auth0 Tenant.

## Directories 
### envs 

### modules 
Terraform branding, clints and users modules'.
1. Branding : In this modules we can customize the user login experience, change the client's logo.
2. clients : In this modules we create the different Apps(SPA & DAE, etc), the Connections and the organizations.
3. users : In this modules we create the DAE roles, users for test.  

### Configuration 
1. Retrieve the Auth0 Domain and Client ID from the Auth0 Dashboard 
2. Fill in the required config variables in the file ``auth_config.json``
```bash 
{
  "domain": " ",
  "clientId": " "
}
```
### Development 
1. Run the development server:
```bash 
cd src/spa
npm start
```
2. Open http://localhost:3000/ in your browser.

3. Use the Login button to authenticate with Auth0(As individual or a client).

### Deployment 
1. Build the project: 

```bash
cd src/react-spa
npm run build
```

2. Deploy the project:

```bash
npx wrangler pages deploy ./dist --project-name <project-name>
```