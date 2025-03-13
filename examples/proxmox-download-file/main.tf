/**
 * # Proxmox Download File Example
 *
 * Source Usage: [root](../../)
 *
 */

module "talos_image_factory" {
  source = "../../"

  # Just pulling latest stable for this example
  talos_version_spec = { pattern = ".*" }

  # Add the qemu agent extension so you can access the VM IP
  find_extensions = ["qemu-guest-agent"]

  # Use `nocloud` so that cloud-init can be used
  platform = "nocloud"
}

locals {
  # The talos version that was selected.
  # Assigning to a local just so it is shorter to reference.
  talos_version = module.talos_image_factory.talos_version
}

resource "proxmox_virtual_environment_download_file" "talos_image" {
  node_name    = var.pve_node_name
  datastore_id = var.pve_datastore_id
  content_type = "iso"

  url       = module.talos_image_factory.urls.disk_image
  file_name = "terraform-talos-image-factory-example-${local.talos_version}.img"

  # This seems to be safe to use for the disk_image urls event if it doesn't
  # have the .zst extension.
  decompression_algorithm = "zst"

  # The filesize will change because it is decompressed, causing a replacement
  # if this isn't set to false.
  overwrite = false
}
