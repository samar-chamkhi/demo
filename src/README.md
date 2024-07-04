# SPA Auth0 
This project is a React Single Page Web Application that uses Auth0 for authentication with an SPA Client. 
The application can be run locally, by cloning the repository to your machine and then following the steps below.

## Getting started 
### Prerequisites 
- CloudFlare account 
- Auth0 Tenant 

### Configuration 
1. Retrieve the Auth0 Domain and Client ID from the Auth0 Dashboard 
2. To specify the application client ID and domain, open ``auth_config.json`` and supply the values for your application : 
```json 
{
  "domain": " ",
  "clientId": " "
}
```
### Installation

After cloning the repository, run:

```bash
$ npm install
```

This will install all of the necessary packages in order for the sample to run. 

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