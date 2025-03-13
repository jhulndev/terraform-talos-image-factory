
terraform {
  required_version = ">= 1.6"
  required_providers {
    talos = {
      source  = "siderolabs/talos"
      version = ">= 0.7"
    }
  }
}
