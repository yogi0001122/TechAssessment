resource "azurerm_storage_account" "storage-account" {
  name                     = var.storgae_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = "LRS"
  tags = var.tags
}

resource "azurerm_storage_container" "azure_blob_container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage-account.name
  container_access_type = "private"
}

resource "azurerm_storage_queue" "azure_storage_queue" {
  for_each             = toset(var.queue_name)
  name                 = each.value
  storage_account_name = azurerm_storage_account.storage-account.name
}

