output "network_name" {
  value = azurerm_virtual_network.vnet_name.name
  description = "Name of the Virtual network"
}

output "subnet_id" {
  value = azurerm_subnet.resource-subnet.id
  description = "Id of websubnet in the network"
}
