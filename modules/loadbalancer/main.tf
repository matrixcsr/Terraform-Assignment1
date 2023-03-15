resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.lb_name}-publicip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "vm_pool" {
  name            = "vm-pool"
  loadbalancer_id = azurerm_lb.lb.id

}



resource "azurerm_lb_probe" "http" {
  name             = "http-probe"
  protocol         = "Http"
  port             = 80
  number_of_probes = 2
  request_path     = "/"
  loadbalancer_id  = azurerm_lb.lb.id

}

resource "azurerm_lb_rule" "http" {
  name                           = "http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.http.id
  loadbalancer_id                = azurerm_lb.lb.id
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.vm_pool.id]
}

/* resource "azurerm_network_interface_backend_address_pool_association" "backend_pool_association" {
  count = length(var.linux_vm_nic_ids)

  network_interface_id    = var.linux_vm_nic_ids[count.index]
  ip_configuration_name   = "ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
} */
