variable "cluster_name" {
  description = "Name of the cluster, used as prefix for all resources"
  type        = string
}

variable "iso_path" {
  description = "Path to the Talos Linux ISO file"
  type        = string
}

variable "network_type" {
  description = "Type of network to create (route, nat, bridge, etc.)"
  type        = string
  default     = "route"
}

variable "network_cidr" {
  description = "CIDR block for the cluster network"
  type        = string
  default     = "172.29.187.0/24"
}

variable "network_gateway" {
  description = "Gateway IP for the cluster network"
  type        = string
  default     = "172.29.187.1"
}

variable "control_plane_count" {
  description = "Number of control plane nodes"
  type        = number
  default     = 3
}

variable "control_plane_vcpu" {
  description = "Number of vCPUs for control plane nodes"
  type        = number
  default     = 4
}

variable "control_plane_memory" {
  description = "Memory in MB for control plane nodes"
  type        = number
  default     = 4096
}

variable "control_plane_disk_size" {
  description = "Disk size in bytes for control plane nodes"
  type        = number
  default     = 107374182400 # 100GB
}

variable "control_plane_suffix" {
  description = "Suffix for control plane node names"
  type        = string
  default     = "cp"
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 3
}

variable "worker_vcpu" {
  description = "Number of vCPUs for worker nodes"
  type        = number
  default     = 4
}

variable "worker_memory" {
  description = "Memory in MB for worker nodes"
  type        = number
  default     = 8192
}

variable "worker_disk_primary_size" {
  description = "Primary disk size in bytes for worker nodes"
  type        = number
  default     = 107374182400 # 100GB
}

variable "worker_disk_secondary_size" {
  description = "Secondary disk size in bytes for worker nodes"
  type        = number
  default     = 214748364800 # 200GB
}

variable "worker_suffix" {
  description = "Suffix for worker node names"
  type        = string
  default     = "wk"
}

variable "libvirt_pool" {
  description = "Libvirt storage pool to use for volumes"
  type        = string
  default     = "default"
}

variable "libvirt_uri" {
  description = "Libvirt connection URI. For local: 'qemu:///system'. For remote SSH: 'qemu+ssh://user@host/system?keyfile=/path/to/key'"
  type        = string
  default     = "qemu:///system"
}
