resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.rg_name
  address_space       = var.vnet_address_space
  location            = var.vnet_location
}

resource "azurerm_subnet" "subnet" {
  resource_group_name  = var.rg_name
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

