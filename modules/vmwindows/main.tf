resource "azurerm_availability_set" "as" {
  name                         = "${var.vm_name_prefix}-as"
  location                     = var.location
  resource_group_name          = var.rg_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}

resource "azurerm_public_ip" "vm_public_ip" {
  name                = "${var.vm_name_prefix}-publicip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name_prefix}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${var.vm_name_prefix}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name_prefix
  location            = var.location
  resource_group_name = var.rg_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  computer_name       = var.vm_name_prefix
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  boot_diagnostics {
    storage_account_uri = var.storage_endpoint
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

}

resource "azurerm_virtual_machine_extension" "antimalware" {
  name                 = "Antimalware"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.7"

  settings = <<SETTINGS
{
  "AntimalwareEnabled": true
}
SETTINGS
}
