variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}
variable "dns_label" {
  type = string
}

variable "vm_name_prefix" {
  type    = string
  default = "8359-windows-vm"
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "boot_diagnostics_storage_uri" {
  description = "URI of the storage account to use for boot diagnostics."
  type        = string
}

variable "antimalware_extension_version" {

  default = "2.2"
}
