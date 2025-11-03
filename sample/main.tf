terraform {
  required_version = ">= 1.0"

  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "~> 0.8.1"
    }
  }
}

provider "libvirt" {
  uri = var.libvirt_uri
}

module "talos_cluster" {
  source = "github.com/bashfulrobot/Talos-booter"

  cluster_name = var.cluster_name
  iso_path     = var.iso_path

  # Network configuration
  network_type    = var.network_type
  network_cidr    = var.network_cidr
  network_gateway = var.network_gateway

  # Control plane configuration
  control_plane_count  = var.control_plane_count
  control_plane_vcpu   = var.control_plane_vcpu
  control_plane_memory = var.control_plane_memory

  # Worker configuration
  worker_count  = var.worker_count
  worker_vcpu   = var.worker_vcpu
  worker_memory = var.worker_memory

  # Libvirt configuration
  libvirt_pool = var.libvirt_pool
}
