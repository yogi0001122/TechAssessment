output "storage_account_id" {
  description = "Storage account id."
  value       = azurerm_storage_account.storage-account.id
}

output "primary_key" {
  description = "Storage Account Primary Key"
  value = azurerm_storage_account.storage-account.primary_access_key
}