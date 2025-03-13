/*******************************************************************************
  Talos Version Validation
 ******************************************************************************/

data "talos_image_factory_versions" "this" {
  filters = {
    stable_versions_only = var.talos_version_spec.stable_only
  }

  lifecycle {
    postcondition {
      condition = (
        var.talos_version_spec.number != null
        ? contains(self.talos_versions, var.talos_version_spec.number)
        : true
      )
      error_message = <<-EOT
        The provided Talos version number '${coalesce(var.talos_version_spec.number, "UNSET")}'
        was not found. Available versions: ${join(", ", self.talos_versions)}
      EOT
    }
    postcondition {
      condition = (
        var.talos_version_spec.pattern != null
        ? anytrue([
          for version in self.talos_versions :
          length(regexall(var.talos_version_spec.pattern, version)) > 0
        ])
        : true
      )
      error_message = <<-EOT
        The provided Talos version pattern '${coalesce(var.talos_version_spec.pattern, "UNSET")}'
        does not match any versions. Available versions: ${join(", ", self.talos_versions)}
      EOT
    }
  }
}

locals {
  filtered_versions = [
    for version in data.talos_image_factory_versions.this.talos_versions :
    version if(
      var.talos_version_spec.number != null
      ? var.talos_version_spec.number == version
      : length(regexall(var.talos_version_spec.pattern, version)) > 0
    )
  ]

  # Get the latest matching version
  talos_version = element(reverse(local.filtered_versions), 0)
}

/*******************************************************************************
  Extensions
 ******************************************************************************/

data "talos_image_factory_extensions_versions" "this" {
  talos_version = local.talos_version
  filters = {
    names = var.find_extensions
  }
}

locals {
  extensions_info = coalesce(data.talos_image_factory_extensions_versions.this.extensions_info, [])
  extensions      = concat(var.extensions, local.extensions_info[*].name)
}

/*******************************************************************************
  Overlays
 ******************************************************************************/

data "talos_image_factory_overlays_versions" "this" {
  count         = var.overlay != null ? 1 : 0
  talos_version = local.talos_version
  filters = {
    name = var.overlay.name
  }

  lifecycle {
    postcondition {
      condition     = length(coalesce(self.overlays_info, [])) > 0
      error_message = <<-EOT
        No overlays found with the name '${var.overlay.name}' for the
        Talos version '${local.talos_version}'.
      EOT
    }
    postcondition {
      condition     = length(coalesce(self.overlays_info, [])) <= 1
      error_message = <<-EOT
        Multiple overlays found with the name '${var.overlay.name}' for the
        Talos version '${local.talos_version}'.
      EOT
    }
  }
}

locals {
  # Format the overlay info into what is expected for the schematic
  overlay_info = one(flatten(data.talos_image_factory_overlays_versions.this[*].overlays_info[*]))
  overlay = local.overlay_info != null ? {
    image   = local._overlay_info.ref
    name    = local._overlay_info.name
    options = var.overlay.options
  } : null
}

/*******************************************************************************
  Schematic
 ******************************************************************************/

resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode({
    customization = {
      extraKernelArgs = var.extra_kernel_args
      meta            = var.meta
      systemExtensions = {
        officialExtensions = local.extensions
      }
      secureboot = var.secureboot
    }
    overlay = local.overlay
  })
}

/*******************************************************************************
  URLs
 ******************************************************************************/

data "talos_image_factory_urls" "this" {
  talos_version = local.talos_version
  schematic_id  = talos_image_factory_schematic.this.id
  architecture  = var.architecture
  platform      = var.platform
  sbc           = var.sbc
}
