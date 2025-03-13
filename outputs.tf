
output "talos_version" {
  value       = local.talos_version
  description = "The final Talos version that was used."
}

output "schematic" {
  value       = talos_image_factory_schematic.this
  description = "The schematic that was generated for the configuration."
}

output "urls" {
  value       = data.talos_image_factory_urls.this.urls
  description = "The urls to download artifacts."
}
