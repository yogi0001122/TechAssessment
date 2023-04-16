# Create the Backend Function app, pass in the App Service Plan ID and Storage account
resource "azurerm_linux_function_app" "functionapp" {
  name                          = var.functionapp_name
  location                      = var.app_location
  resource_group_name           = var.rg_name
  service_plan_id               = var.service_plan_id
  tags                          = var.tags
  storage_account_name          = var.storage_account_name
  storage_account_access_key    = var.storage_account_access_key
  site_config {}
}
