# Resource Group variable

variable "rg_name" {}
variable "location" {}

#Vnet variables
variable "vnet_name" {
  default = "challenge1vnet"
}

variable "address_space" {
  type        = list(string)
  description = "The address spcae that is used by the virtual network"
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  default     = "challengesubnet"
  description = "The name of subnet to which resource will be created"
}

variable "subnet_address_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
  default     = ["10.1.0.0/24"]
}

#Tags
variable "tags" {
  type = map(string)
  default = {
    "BU" = "challenge1"
  }
}

#Storgae Account variable

variable "storgae_account_name" {
  default     = "storagechallenge1"
  description = "Specifies the name of the Storage Account."
}

#variable "cors" {}    # Setting CORS in Azure storage account

variable "account_tier" {
  default = "Standard"
}

variable "storage_container_name" {
  default = "containerchallenge1"
}

variable "queue_name" {
  type        = list(string)
  default     = []
  description = "Required the queue names for binding with function apps"
}

#Cosmos DB

variable "cosmos_database_account_name" {
  default = "cosmoschallenge1"
}

variable "cosmos_sql_db_name" {
  default = "techchallenge"
  description = "SQl DB"
}


variable "cosmos_conatiner_name" {
  default = "cosmoscontainerchallenge1"
}

#Azure congnitive Servives and Communication Service

variable "computer_vision_service" {
  default     = "cvchallenege1"
  description = "Computer vision for OCR"
}

variable "singnal_R_name" {
  default     = "singnalrchallenge1"
  description = "Communication Service"
}

# KeyVault

variable "kv_name" {
  default     = "kvchallenge1"
  description = "Key Vault for challenge 1"
}

#App Service Plan

variable "app_service_plan_name" {
  default     = "aspchallelge1"
  description = "App service plan for web app and function app"
}

variable "sku_name" {
  default     = "F1"
  description = "Pricing Tier for App Service plan"
}

variable "os_type_linux" {
  default     = "Linux"
  description = "Linux Os Type"
}

variable "os_type_windows" {
  default     = "Windows"
  description = "Windows Os Type"
}

variable "app_location" {
  default = "Central US"
  description = "Allowed location"
}

# Web App

variable "webapp_name" {
  default     = "webappchallenge1"
  description = "Web App To host fromtend app"
}

# Function App
variable "functionapp_name" {
  default     = "functionappchallenge1"
  description = "Web App To host fromtend app"
}
