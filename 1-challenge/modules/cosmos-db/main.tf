resource "azurerm_cosmosdb_account" "cosmos_db_account" {
    name = var.cosmos_database_account_name
    location = var.location
    resource_group_name = var.rg_name
    tags = var.tags
    offer_type = "Standard"
    kind = "GlobalDocumentDB"
    consistency_policy {
        consistency_level = "BoundedStaleness"
        max_interval_in_seconds = 10
        max_staleness_prefix = 200
    }
    geo_location {
        location = var.geo_location
        failover_priority = 0
    }
}

resource "azurerm_cosmosdb_sql_database" "cosmos_sqldb" {
  name = var.cosmos_sql_db_name
  resource_group_name = var.rg_name
  account_name = azurerm_cosmosdb_account.cosmos_db_account.name
}

resource "azurerm_cosmosdb_sql_container" "cosmos_db_container" {
  name                  = var.cosmos_conatiner_name
  resource_group_name   = var.rg_name
  account_name          = azurerm_cosmosdb_account.cosmos_db_account.name
  database_name         = azurerm_cosmosdb_sql_database.cosmos_sqldb.name
  partition_key_path    = "/definition/id"
  partition_key_version = 1
  throughput            = 400
  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}