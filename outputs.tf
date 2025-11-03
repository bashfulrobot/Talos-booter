output "network_id" {
  description = "ID of the created libvirt network"
  value       = libvirt_network.cluster_network.id
}

output "network_name" {
  description = "Name of the created libvirt network"
  value       = libvirt_network.cluster_network.name
}

output "control_plane_names" {
  description = "Names of control plane VMs"
  value       = [for vm in libvirt_domain.control_plane : vm.name]
}

output "control_plane_ids" {
  description = "IDs of control plane VMs"
  value       = [for vm in libvirt_domain.control_plane : vm.id]
}

output "worker_names" {
  description = "Names of worker VMs"
  value       = [for vm in libvirt_domain.worker : vm.name]
}

output "worker_ids" {
  description = "IDs of worker VMs"
  value       = [for vm in libvirt_domain.worker : vm.id]
}

output "all_vm_names" {
  description = "All VM names in the cluster"
  value       = concat([for vm in libvirt_domain.control_plane : vm.name], [for vm in libvirt_domain.worker : vm.name])
}
