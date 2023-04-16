variable "rg_name"{}
variable "location" {}
variable "service_plan_id" {}
variable "storage_account_name" {}
variable "storage_account_access_key" {}

variable "functionapp_name" {
  default     = "functionappchallenge1"
  description = "Function App to host backend app"
}

variable "app_location" {
  default = "Central US"
  description = "Allowed location"
}

variable "tags" {
  type = map(string)
  default = {
    "BU" = "challenge1"
  }
}