resource "null_resource" "display_hostnames" {
  count = var.vm_count

  depends_on = [azurerm_linux_virtual_machine.vm]

  connection {
    type        = "ssh"
    user        = var.admin_username
    private_key = file(var.private_key)
    host        = azurerm_linux_virtual_machine.vm[count.index].public_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "hostname"
    ]
  }
}
