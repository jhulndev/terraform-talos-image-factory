
output "pve_file_id" {
  value       = proxmox_virtual_environment_download_file.talos_image.id
  description = "The disk image to use to boot Proxmox VMs."
}

output "installer" {
  value       = module.talos_image_factory.urls.installer
  description = "Use this installer image for upgrades."
}
