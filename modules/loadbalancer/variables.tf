variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "vm_ids" {
  type        = list(string)
}
