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

### Network
- `network_type` - Network mode (default: "route")
- `network_cidr` - Network CIDR (default: "172.29.187.0/24")
- `network_gateway` - Gateway IP (default: "172.29.187.1")

### Control Plane
- `control_plane_count` - Number of nodes (default: 3)
- `control_plane_vcpu` - vCPUs per node (default: 4)
- `control_plane_memory` - Memory in MB (default: 4096)
- `control_plane_disk_size` - Disk size in bytes (default: 107374182400 = 100GB)
- `control_plane_suffix` - Node name suffix (default: "cp")

### Worker
- `worker_count` - Number of nodes (default: 3)
- `worker_vcpu` - vCPUs per node (default: 4)
- `worker_memory` - Memory in MB (default: 8192)
- `worker_disk_primary_size` - Primary disk size in bytes (default: 107374182400 = 100GB)
- `worker_disk_secondary_size` - Secondary disk size in bytes (default: 214748364800 = 200GB)
- `worker_suffix` - Node name suffix (default: "wk")

### Libvirt
- `libvirt_pool` - Storage pool name (default: "default")
- `libvirt_uri` - Connection URI (default: "qemu:///system")

## Outputs

- `network_name` - Created network name
- `control_plane_names` - List of control plane VM names
- `worker_names` - List of worker VM names
- `all_vm_names` - All VM names in cluster
