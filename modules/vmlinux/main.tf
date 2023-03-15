resource "azurerm_availability_set" "as" {
  name                         = var.as_name
  location                     = var.location
  resource_group_name          = var.rg_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}

resource "azurerm_public_ip" "vm_public_ip" {
  count               = var.vm_count
  name                = "${var.vm_name_prefix}-${count.index}-publicip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  domain_name_label   = "${var.dns_label}-${count.index}-gov"
}

resource "azurerm_network_interface" "vm_nic" {
  count               = var.vm_count
  name                = "${var.vm_name_prefix}-${count.index}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${var.vm_name_prefix}-${count.index}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip[count.index].id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.vm_count
  name                = "${var.vm_name_prefix}-${count.index}"
  computer_name       = "${var.vm_name_prefix}-${count.index}"
  location            = var.location
  resource_group_name = var.rg_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key)
  }

  network_interface_ids = [
    azurerm_network_interface.vm_nic[count.index].id,
  ]

  os_disk {
    name                 = "${var.vm_name_prefix}-${count.index}-os-disk"
    caching              = var.os_disk_attributes.caching
    storage_account_type = var.os_disk_attributes.storage_account_type
    disk_size_gb         = var.os_disk_attributes.disk_size
  }

  boot_diagnostics {
    storage_account_uri = var.storage_endpoint
  }

  source_image_reference {
    publisher = var.linux_os_information.publisher
    offer     = var.linux_os_information.offer
    sku       = var.linux_os_information.sku
    version   = var.linux_os_information.version
  }
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  count                      = var.vm_count
  name                       = "NW-8359"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm[count.index].id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
}
