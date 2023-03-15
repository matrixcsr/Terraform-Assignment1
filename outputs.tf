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

output "vm_private_ipsmain" {
  value = module.vmlinux.vm_private_ips
}

output "vm_public_ipsmain" {
  value = module.vmlinux.vm_public_ips
}
# output "lb_namemain" {
#   value = module.loadbalancer.lb_name
# }
