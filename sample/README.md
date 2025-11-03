# Talos-booter Sample

Sample implementation using the Talos-booter Terraform module.

## Summary

Demonstrates usage of the Talos-booter module to bootstrap VMs (1 control plane node and 2 worker nodes) that boot from Talos ISO, ready for Omni to provision and manage the cluster.

## Prerequisites

- Terraform >= 1.0
- libvirt/KVM running
- Talos Linux ISO downloaded

## Usage

1. Copy the example variables:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars`:
   ```hcl
   cluster_name = "dev-lab"
   iso_path     = "/path/to/talos.iso"

   # Optional: customize resources, networking, node naming, etc.
   # See terraform.tfvars.example for all available options

   # For remote libvirt over SSH:
   # libvirt_uri = "qemu+ssh://user@host/system?keyfile=/path/to/ssh/key"
   ```

3. Deploy:
   ```bash
   terraform init
   terraform apply
   ```

4. Cleanup:
   ```bash
   terraform destroy
   ```

## What Gets Created

- Network: `{cluster_name}-network`
- Control plane: `{cluster_name}-cp01`
- Workers: `{cluster_name}-wk01`, `{cluster_name}-wk02`

## Module Source

This sample references the module from GitHub:
```hcl
source = "github.com/bashfulrobot/Talos-booter"
```
