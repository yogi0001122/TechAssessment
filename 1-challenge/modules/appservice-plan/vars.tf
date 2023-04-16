variable "rg_name"{}
variable "location" {}

variable "app_service_plan_name" {
  default     = "aspchallelge1"
  description = "App service plan for web app and function app"
}

variable "app_location" {
  default = "Central US"
  description = "Allowed location"
}

variable "sku_name" {
  default     = "F1"
  description = "Pricing Tier for App Service plan"
}

variable "os_type" {
  default     = "Linux"
  description = "Os Type"
}

variable "tags" {
  type = map(string)
  default = {
    "BU" = "challenge1"
  }
}