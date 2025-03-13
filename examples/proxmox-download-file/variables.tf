
variable "pve_node_name" {
  type        = string
  description = "The Proxmox node that will be used to download the image."
}

variable "pve_datastore_id" {
  type        = string
  default     = "local"
  description = "The Proxmox datastore id that the image will be downloaded to."
}
