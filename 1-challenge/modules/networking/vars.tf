variable "rg_name"{}
variable "location" {}

variable "vnet_name" {
  default = "challenge1vnet"
}

variable "address_space" {
    type = list(string)
    description = "The address spcae that is used by the virtual network"
    default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  default     = "challenge-1-subnet"
  description = "The name of subnet to which resource will be created"
}

variable "subnet_address_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
  default     = ["10.1.0.0/24"]
}
