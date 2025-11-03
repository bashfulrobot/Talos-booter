terraform {
  required_version = ">= 1.0"

  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "~> 0.8.1"
    }
  }
}

# Create network for the cluster
resource "libvirt_network" "cluster_network" {
  name      = "${var.cluster_name}-network"
  mode      = var.network_type
  addresses = [var.network_cidr]
  autostart = true

  dns {
    enabled = true
  }
}

# Create volume for the ISO
resource "libvirt_volume" "talos_iso" {
  name   = "${var.cluster_name}-talos.iso"
  pool   = var.libvirt_pool
  source = var.iso_path
  format = "raw"
}

# Create control plane nodes
resource "libvirt_volume" "control_plane_disk" {
  count  = var.control_plane_count
  name   = "${var.cluster_name}-${var.control_plane_suffix}${format("%02d", count.index + 1)}-disk.qcow2"
  pool   = var.libvirt_pool
  format = "qcow2"
  size   = var.control_plane_disk_size
}

resource "libvirt_domain" "control_plane" {
  count  = var.control_plane_count
  name   = "${var.cluster_name}-${var.control_plane_suffix}${format("%02d", count.index + 1)}"
  memory = var.control_plane_memory
  vcpu   = var.control_plane_vcpu

  disk {
    volume_id = libvirt_volume.control_plane_disk[count.index].id
  }

  disk {
    file = var.iso_path
  }

  network_interface {
    network_id     = libvirt_network.cluster_network.id
    wait_for_lease = false
  }

  boot_device {
    dev = ["cdrom", "hd"]
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "vnc"
    listen_type = "address"
  }
}

# Create worker nodes with primary disk
resource "libvirt_volume" "worker_disk_primary" {
  count  = var.worker_count
  name   = "${var.cluster_name}-${var.worker_suffix}${format("%02d", count.index + 1)}-disk-primary.qcow2"
  pool   = var.libvirt_pool
  format = "qcow2"
  size   = var.worker_disk_primary_size
}

# Create worker nodes with secondary disk
resource "libvirt_volume" "worker_disk_secondary" {
  count  = var.worker_count
  name   = "${var.cluster_name}-${var.worker_suffix}${format("%02d", count.index + 1)}-disk-secondary.qcow2"
  pool   = var.libvirt_pool
  format = "qcow2"
  size   = var.worker_disk_secondary_size
}

resource "libvirt_domain" "worker" {
  count  = var.worker_count
  name   = "${var.cluster_name}-${var.worker_suffix}${format("%02d", count.index + 1)}"
  memory = var.worker_memory
  vcpu   = var.worker_vcpu

  disk {
    volume_id = libvirt_volume.worker_disk_primary[count.index].id
  }

  disk {
    volume_id = libvirt_volume.worker_disk_secondary[count.index].id
  }

  disk {
    file = var.iso_path
  }

  network_interface {
    network_id     = libvirt_network.cluster_network.id
    wait_for_lease = false
  }

  boot_device {
    dev = ["cdrom", "hd"]
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "vnc"
    listen_type = "address"
  }
}
