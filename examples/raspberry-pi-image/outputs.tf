
output "schematic_id" {
  value = module.talos_image_factory.schematic.id
}

output "disk_image" {
  value       = module.talos_image_factory.urls.disk_image
  description = "Use this disk_image for first boot."
}

output "installer" {
  value       = module.talos_image_factory.urls.installer
  description = "Use this installer image for upgrades."
}
