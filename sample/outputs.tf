output "network_name" {
  description = "Name of the created libvirt network"
  value       = module.talos_cluster.network_name
}

output "control_plane_names" {
  description = "Names of control plane VMs"
  value       = module.talos_cluster.control_plane_names
}

output "worker_names" {
  description = "Names of worker VMs"
  value       = module.talos_cluster.worker_names
}

output "all_vm_names" {
  description = "All VM names in the cluster"
  value       = module.talos_cluster.all_vm_names
}
