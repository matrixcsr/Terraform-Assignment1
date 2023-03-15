terraform {
  backend "azurerm" {
    storage_account_name = "tfstate8359sa"
    resource_group_name  = "tfstate8359RG"
    container_name       = "tfstatefiles"
    key                  = "0KaZUINUY49DTscc+hFXz5kXoGpmdDPpUOVnHzfOfkp7XUZ6WKRrXZuYc1qRRcNrCnS2XJlTPZ0c+AStnHzLOg=="
  }
}