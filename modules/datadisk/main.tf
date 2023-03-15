resource "azurerm_managed_disk" "datadisk" {
  count              = 3
  name               = "${var.disk_names}-${count.index}-datadisk"
  location           = var.location
  resource_group_name= var.rg_name
  storage_account_type = "Standard_LRS"
  create_option      = "Empty"
  disk_size_gb       = var.disk_size_gb
  
}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk_attachment" {
  depends_on = [
    azurerm_managed_disk.datadisk
  ]
  count              = length(var.vm_ids)
  managed_disk_id    = azurerm_managed_disk.datadisk[count.index].id
  virtual_machine_id = var.vm_ids[count.index]
  lun                = count.index
  caching            = "ReadWrite"
}
