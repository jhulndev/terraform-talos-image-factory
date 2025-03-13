
variable "talos_version_spec" {
  type = object({
    number      = optional(string)
    pattern     = optional(string)
    stable_only = optional(bool, true)
  })
  default = {
    pattern = ".*"
  }
  nullable    = false
  description = <<-EOT
    A specification to describe what Talos version number to pull. One, and only
    one of `number` or `pattern` must be provided.

    * `number`: An exact version number to use. Must match an existing Talos version
          number exactly. May be a pre-release version number if `stable_only`
          is `false`.
    * `pattern`: A regex pattern that will be matched against to find eligible
          Talos versions. The latest matching version will be used.
    * `stable_only`: When `true`, only stable versions will be considered.
  EOT

  validation {
    condition     = var.talos_version_spec.number != null || var.talos_version_spec.pattern != null
    error_message = "Either the talos_version_spec number or pattern must be provided."
  }
  validation {
    condition     = !(var.talos_version_spec.number != null && var.talos_version_spec.pattern != null)
    error_message = "Only one of the talos_version_spec number or pattern must be provided."
  }
}

/*******************************************************************************
  Schematic Configuration
 ******************************************************************************/

variable "find_extensions" {
  type        = list(string)
  nullable    = false
  default     = []
  description = <<-EOT
    List of extension names that will be used to search the extension list.
  EOT
}

variable "extensions" {
  type        = list(string)
  nullable    = false
  default     = []
  description = <<-EOT
    List of extensions that will be added as-is to the schematic
    configuration of `officialExtensions`.
  EOT
}

variable "overlay" {
  type = object({
    name    = string
    options = optional(any)
  })
  nullable    = true
  default     = null
  description = "The overlay and options to apply."
}

variable "extra_kernel_args" {
  type        = list(string)
  nullable    = false
  default     = []
  description = <<-EOT
    List of extra kernel arguments that will be added as-is to the schematic
    configuration of `extraKernelArgs`.
  EOT
}

variable "meta" {
  type = list(object({
    key   = string
    value = string
  }))
  nullable    = false
  default     = []
  description = "Allows to set initial Talos META"
}

variable "secureboot" {
  type        = any
  nullable    = true
  default     = null
  description = "The `secureboot` configuration, only applies to SecureBoot images."
}

/*******************************************************************************
  URL Configuration
 ******************************************************************************/

variable "architecture" {
  type        = string
  nullable    = true
  default     = "amd64"
  description = "The platform architecture for which the URLs are generated."
}

variable "platform" {
  type        = string
  nullable    = true
  default     = null
  description = "The platform for which the URLs are generated."
}

variable "sbc" {
  type        = string
  nullable    = true
  default     = null
  description = "The SBC's (Single Board Computers) for which the URLs are generated."
}
