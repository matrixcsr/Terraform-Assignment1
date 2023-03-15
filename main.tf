module "rg_group" {
  source = "./modules/rgroup"

  rg_name     = "N8359-assignment1-RG"
  rg_location = "Canada East"
}

module "rg_network" {
  source = "./modules/network"

  rg_name                 = module.rg_group.rg_name
  vnet_name               = "8359-vnet"
  vnet_address_space      = ["10.0.0.0/16"]
  vnet_location           = module.rg_group.rg_location
  subnet_name             = "my-subnet"
  subnet_address_prefixes = ["10.0.1.0/24"]
}

module "common_resource" {
  source = "./modules/common"

  rg_name      = module.rg_group.rg_name
  law_name     = "law-8359"
  law_location = module.rg_group.rg_location
  rsv_name     = "rsv-8359"
  rsv_location = module.rg_group.rg_location
  sa_name      = "storageaccount8359"
  sa_location  = module.rg_group.rg_location
}

module "vmlinux" {
  source = "./modules/vmlinux"

  rg_name          = module.rg_group.rg_name
  subnet_id        = module.rg_network.subnet_id
  dns_label        = "matrix8359"
  vm_count         = 2
  location         = module.rg_group.rg_location
  admin_username   = "linuxmatrix8359"
  storage_endpoint = module.common_resource.storage_endpoint
  # spn_client_secret = "8359-secret"
}

module "vmwindows" {
  source = "./modules/vmwindows"

  rg_name          = module.rg_group.rg_name
  location         = module.rg_group.rg_location
  subnet_id        = module.rg_network.subnet_id
  dns_label        = "nottrademarkmatrix8359"
  vm_name_prefix   = "vmwindows"
  vm_size          = "Standard_B2ms"
  admin_username   = "matrix8359"
  admin_password   = "Sherway938"
  storage_endpoint = module.common_resource.storage_endpoint
  
}

module "datadisk" {
  source = "./modules/datadisk"

  rg_name  = module.rg_group.rg_name
  location = module.rg_group.rg_location
  vm_ids = [
    module.vmlinux.vm_ids[0],
    module.vmlinux.vm_ids[1],
    module.vmwindows.vm_id
  ]
}

module "database" {
  source = "./modules/database"

  rg_name     = module.rg_group.rg_name
  location    = module.rg_group.rg_location
  db_name     = "post8359"
  server_name = "postgres8359"
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  rg_name  = module.rg_group.rg_name
  location = module.rg_group.rg_location
  lb_name  = "8359-loadbalancer"
  vm_ids = [
    module.vmlinux.vm_ids[0],
    module.vmlinux.vm_ids[1],
    module.vmwindows.vm_id
  ]
  subnet_id = module.rg_network.subnet_id
}
