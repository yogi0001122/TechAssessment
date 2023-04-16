output "app_service_plan_id" {
  description = "App Service Plan id."
  value       = azurerm_service_plan.app_service_plan.id
}