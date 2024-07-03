# SPA Auth0 
This project is a React Single Page Web Application that uses Auth0 for authentication with an SPA Client

## Getting started 
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

3. Use the Login button to authenticate with Auth0.

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