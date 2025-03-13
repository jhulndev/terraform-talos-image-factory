
terraform {
  required_version = ">= 1.6"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.73"
    }
    talos = {
      source  = "siderolabs/talos"
      version = ">= 0.7"
    }
  }
}
