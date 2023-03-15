output "vm_id" {
  value = azurerm_windows_virtual_machine.vm.id
}
output "public_ip_address" {
  value = azurerm_public_ip.vm_public_ip.ip_address
}
output "private_ip_address" {
  value = azurerm_network_interface.vm_nic.private_ip_address
}
