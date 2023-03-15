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
  allocation_method   = "Static"
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

  # boot_diagnostics {
  #   enabled     = true
  #   storage_uri = var.boot_diagnostics_storage_uri
  # }

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

  #   extension {
  #     name                 = "IaaSAntimalware"
  #     publisher            = "Microsoft.Azure.Security"
  #     type                 = "IaaSAntimalware"
  #     type_handler_version = var.antimalware_extension_version
  #     settings             = <<SETTINGS
  #       {
  #         "AntimalwareEnabled": true,
  #         "RealtimeProtectionEnabled": true,
  #         "ScheduledScanSettings": {
  #           "isEnabled": true,
  #           "day": "1",
  #           "time": "120"
  #         },
  #         "Exclusions": {
  #           "Extensions": "",
  #           "Paths": ""
  #         },
  #         "MonitoringMode": 1,
  #         "ThreatSeverityDefaultAction": 4
  #       }
  # SETTINGS
  #   }
}
