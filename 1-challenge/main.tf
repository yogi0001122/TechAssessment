terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
  # Setup variables for backend resources
  backend "azurerm" {
    resource_group_name  = "devops-terraform"
    storage_account_name = "devopschalleng1"
    container_name       = "terraformstatefile"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Create Resource Group
module "resourcegroup" {
  source   = "./modules/resourcegroup"
  rg_name  = var.rg_name
  location = var.location
}

# Create Vnet and Subnet
module "networking" {
  source                  = "./modules/networking"
  vnet_name               = var.vnet_name
  location                = module.resourcegroup.location_id
  rg_name                 = module.resourcegroup.resource_group_name
  address_space           = var.address_space
  subnet_name             = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  depends_on              = [module.resourcegroup]
}

# Create Azure Storage, containers and Queues 
module "storage-account" {
  source                    = "./modules/storage-account"
  storgae_account_name      = var.storgae_account_name
  location                  = module.resourcegroup.location_id
  rg_name                   = module.resourcegroup.resource_group_name
  account_tier              = var.account_tier
  storage_container_name    = var.storage_container_name
  queue_name                = var.queue_name
  tags                      = var.tags
  depends_on                = [module.resourcegroup]
}

 
# Create Cosmos DB and Containers 
module "cosmos-db" {
  source                        = "./modules/cosmos-db"
  cosmos_database_account_name  = var.cosmos_database_account_name
  location                      = module.resourcegroup.location_id
  rg_name                       = module.resourcegroup.resource_group_name
  cosmos_sql_db_name            = var.cosmos_sql_db_name
  cosmos_conatiner_name         = var.cosmos_conatiner_name
  tags                          = var.tags
  depends_on                    = [module.resourcegroup]
}


# App Service plan 
module "appservice-plan" {
  source                        = "./modules/appservice-plan"
  app_service_plan_name         = var.app_service_plan_name
  location                      = module.resourcegroup.location_id
  rg_name                       = module.resourcegroup.resource_group_name
  sku_name                      = var.sku_name
  os_type                       = var.os_type_linux
  tags                          = var.tags
  depends_on                    = [module.resourcegroup]
}


# create Web App
module "web-app" {
  source                        = "./modules/web-app"
  webapp_name                   = var.webapp_name
  location                      = module.resourcegroup.location_id
  rg_name                       = module.resourcegroup.resource_group_name
  app_location                  = var.app_location
  service_plan_id               = module.appservice-plan.app_service_plan_id
  tags                          = var.tags
  depends_on                    = [module.resourcegroup,module.appservice-plan]
}


# create backend function apps
module "backend-functionapps" {
  source                        = "./modules/backend-functionapps"
  functionapp_name              = var.functionapp_name
  rg_name                       = module.resourcegroup.resource_group_name
  location                      = module.resourcegroup.location_id
  app_location                  = var.app_location
  service_plan_id               = module.appservice-plan.app_service_plan_id
  tags                          = var.tags
  storage_account_name          = basename(module.storage-account.storage_account_id)
  storage_account_access_key    = module.storage-account.primary_key
  depends_on                    = [module.resourcegroup,module.storage-account,module.appservice-plan]
}
