# Create the web app, pass in the App Service Plan ID
resource "azurerm_linux_web_app" "webapp" {
  name                  = var.webapp_name
  location              = var.app_location
  resource_group_name   = var.rg_name
  service_plan_id       = var.service_plan_id
  tags                  = var.tags
  https_only            = true
  site_config { 
    #linux_fx_version = "node|16-lts"
    #minimum_tls_version = "1.2"
  }
}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.webapp.id
  repo_url           = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
  branch             = "master"
  use_manual_integration = true
  use_mercurial      = false
}