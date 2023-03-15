output "my_rg_namemain" {
  value = module.rg_group.rg_name
}

output "my_law_namemain" {
  value = module.common_resource
}

output "my_rsv_namemain" {
  value = module.common_resource.rsv_name
}

output "my_sa_namemain" {
  value = module.common_resource.sa_name
}
output "my_vnet_namemain" {
  value = module.rg_network.vnet
}

output "my_subnet_namemain" {
  value = module.rg_network
}
output "vm_hostnamesmain" {
  value = module.vmlinux.vm_hostnames
}

output "vm_domain_namesmain" {
  value = module.vmlinux.vm_domain_names
}

output "lin_vm_private_ipsmain" {
  value = module.vmlinux.vm_private_ips
}

output "lin_vm_public_ipsmain" {
  value = module.vmlinux.vm_public_ips
}
output "db" {
  value = module.database.postgresql_server_name
}
output "win_vm_private_ip" {
  value = module.vmwindows.private_ip_address
}
output "win_vm_public_ipsmain" {
  value = module.vmwindows.public_ip_address
}