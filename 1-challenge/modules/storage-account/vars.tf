variable "rg_name"{}
variable "location" {}

variable "storgae_account_name" {
  default     = "storagechallenge1"
  description = "Specifies the name of the Storage Account."
}

variable "network_subnet_id" {
  type = string
  default = ""
  description = "Add Subnet"
}

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

variable "tags" {
  type = map(string)
  default = {
    "BU" = "challenge1"
  }
}

#variable "cors" {}    # Setting CORS in Azure storage account