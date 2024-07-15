module "auth0_clients" {
    source = "../../modules/clients"

    # Client URLs
    spa_url = "http://localhost:3000"
    # dae_url = "https://demo-sada.eu.webtask.run/auth0-delegated-admin"
    # ssr_url = "https://hokus.lyvoc.workers.dev"

    # Okta connection domain
    okta_connetion_domain = "demo-yellow-smelt-12003.okta.com"

}