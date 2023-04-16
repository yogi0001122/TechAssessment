variable "rg_name"{}
variable "location" {}


variable "geo_location" {
    type = string
    default = "South India"
    description = "Cosmos geo location"
}

variable "cosmos_database_account_name" {
  default = "cosmoschallenge1"
  description = "Cosmos DB account name"
}

variable "cosmos_sql_db_name" {
  default = "techchallenge"
  description = "SQl DB"
}

variable "cosmos_conatiner_name" {
  default = "cosmoscontainerchallenge1"
}

variable "tags" {
  type = map(string)
  default = {
    "BU" = "challenge1"
  }
}