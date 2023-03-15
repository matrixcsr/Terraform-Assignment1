variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_ids" {
  type = list(string)
}

variable "disk_names" {
  type    = string
  default = "datadisk"
}

variable "disk_size_gb" {
  default = 10
}
