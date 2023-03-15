output "vnet" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_name"{
    value = azurerm_subnet.subnet
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}
output "vnet_space" {
  value = azurerm_virtual_network.vnet.address_space
}