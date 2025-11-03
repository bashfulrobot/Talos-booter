# Talos-booter

Terraform module for bootstrapping Talos Linux VMs on libvirt/KVM for Omni deployment.

## Summary

Boots VMs with Talos Linux ISO images, creating an infrastructure foundation ready to be provisioned and managed by Omni. Provides configurable control plane and worker nodes with networking and multi-disk support. The VMs boot from the ISO and await Omni to deploy and configure the actual Talos cluster.

## Prerequisites

- Terraform >= 1.0
- libvirt/KVM
- Talos Linux ISO
- libvirt storage pool (default: "default")

## Usage

### Local libvirt

```hcl
module "talos_cluster" {
  source = "github.com/bashfulrobot/Talos-booter"

  cluster_name = "dev-lab"
  iso_path     = "/path/to/talos.iso"

  control_plane_count = 3
  worker_count        = 3
}
```

### Remote libvirt over SSH

```hcl
module "talos_cluster" {
  source = "github.com/bashfulrobot/Talos-booter"

  cluster_name = "dev-lab"
  iso_path     = "/path/to/talos.iso"
  libvirt_uri  = "qemu+ssh://user@remote-host/system?keyfile=/path/to/ssh/key"

  control_plane_count = 3
  worker_count        = 3
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
