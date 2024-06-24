module "auth0_clients" {
  source = "../../modules/clients"

  project = "default"
  spa_url = "https://spa-okta-cic-auth0.pages.dev/"
  ssr_url = "https://regular-web-app-okta-cic-auth0.lyvoc.workers.dev/"
}
