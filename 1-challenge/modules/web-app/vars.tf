variable "rg_name"{}
variable "service_plan_id" {}
variable "location" {}

variable "webapp_name" {
  default     = "webappchallenge1"
  description = "Web App To host fromtend app"
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