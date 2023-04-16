resource "azurerm_virtual_network" "vnet_name" {
  name                  = var.vnet_name
  resource_group_name   = var.rg_name
  location              = var.location
  address_space         = var.address_space
}

resource "azurerm_subnet" "resource-subnet" {
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.vnet_name.name
  resource_group_name  = var.rg_name
  address_prefixes     = var.subnet_address_prefixes
}