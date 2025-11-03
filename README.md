# Talos-booter

Terraform module for creating Talos Linux clusters on libvirt/KVM.

## Summary

Creates a complete Talos Linux cluster environment with configurable control plane and worker nodes, networking, and multi-disk support. Designed for lab and testing environments, ready for provisioning with Omni.

## Prerequisites

- Terraform >= 1.0
- libvirt/KVM
- Talos Linux ISO
- libvirt storage pool (default: "default")

## Usage

```hcl
module "talos_cluster" {
  source = "github.com/YOUR_USERNAME/Talos-booter"

  cluster_name = "dev-lab"
  iso_path     = "/path/to/talos.iso"

  control_plane_count = 3
  worker_count        = 3
}

provider "libvirt" {
  uri = "qemu:///system"
}
```

## Required Variables

- `cluster_name` - Name prefix for all resources
- `iso_path` - Full path to Talos Linux ISO

## Key Optional Variables

- `control_plane_count` - Number of control plane nodes (default: 3)
- `worker_count` - Number of worker nodes (default: 3)
- `control_plane_memory` - Memory in MB (default: 4096)
- `worker_memory` - Memory in MB (default: 8192)
- `network_cidr` - Network CIDR (default: "172.29.187.0/24")
- `libvirt_pool` - Storage pool name (default: "default")

See variables.tf for complete list.

## Outputs

- `network_name` - Created network name
- `control_plane_names` - List of control plane VM names
- `worker_names` - List of worker VM names
- `all_vm_names` - All VM names in cluster
