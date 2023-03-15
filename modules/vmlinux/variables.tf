variable "as_name" {
  type    = string
  default = "8359-linux-avs"
}
variable "dns_label" {
  type = string
}

# variable "boot_diagnostics_storage_uri" {
#   type = string
# }
variable "location" {
  type = string
}

# variable "spn_tenant_id" {
#   type = string
# }
# variable "spn_client_id" {
#   type = string
# }
# variable "spn_client_secret" {
#   type = string
# }
variable "rg_name" {
  type = string
}

variable "vm_count" {
  default = 2
}
variable "vm_name_prefix" {
  type    = string
  default = "8359-linux-vm"
}
locals {
  Project        = "Automation Project – Assignment 1"
  Name           = "Matrix.Matrix"
  ExpirationDate = "2023-06-30"
  Environment    = "Lab"
}
variable "subnet_id" {
  type = string
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "admin_username" {
  type = string
}
variable "public_key" {
  default = "C:\\Users\\rsoni\\.ssh\\id_rsa.pub"
}
variable "private_key" {
  default = "C:\\Users\\rsoni\\.ssh\\id_rsa"
}
variable "os_disk_attributes" {
  default = {
    storage_account_type = "Premium_LRS"
    disk_size            = 32
    caching              = "ReadWrite"
  }
}
variable "linux_os_information" {
  default = {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }


}
variable "storage_endpoint" {
  type = string
}
