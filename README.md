# Talos Image Factory Terraform module

Terraform module to generate Talos Image Factory URLs.

This will effectively replicate creating the schematic ids and version
urls that can be created through https://factory.talos.dev/,
allowing for the full provisioning of Talos VMs in virtualized
or cloud environments without having to pull these urls separately.

This module will also provide some flexibiliy in how Talos versions can be
pulled (see [Version Selection](examples/version-selection/main.tf)), and
will check that selected versions and overlays are valid.


## Examples
- [Version Selection](examples/version-selection/)
- [Proxmox Download File](examples/proxmox-download-file/)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >= 0.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_talos"></a> [talos](#provider\_talos) | >= 0.7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [talos_image_factory_schematic.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/image_factory_schematic) | resource |
| [talos_image_factory_extensions_versions.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_extensions_versions) | data source |
| [talos_image_factory_overlays_versions.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_overlays_versions) | data source |
| [talos_image_factory_urls.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_urls) | data source |
| [talos_image_factory_versions.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_versions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_talos_version_spec"></a> [talos\_version\_spec](#input\_talos\_version\_spec) | A specification to describe what Talos version number to pull. One, and only<br/>one of `number` or `pattern` must be provided.<br/><br/>* `number`: An exact version number to use. Must match an existing Talos version<br/>      number exactly. May be a pre-release version number if `stable_only`<br/>      is `false`.<br/>* `pattern`: A regex pattern that will be matched against to find eligible<br/>      Talos versions. The latest matching version will be used.<br/>* `stable_only`: When `true`, only stable versions will be considered. | <pre>object({<br/>    number      = optional(string)<br/>    pattern     = optional(string)<br/>    stable_only = optional(bool, true)<br/>  })</pre> | <pre>{<br/>  "pattern": ".*"<br/>}</pre> | no |
| <a name="input_find_extensions"></a> [find\_extensions](#input\_find\_extensions) | List of extension names that will be used to search the extension list. | `list(string)` | `[]` | no |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | List of extensions that will be added as-is to the schematic<br/>configuration of `officialExtensions`. | `list(string)` | `[]` | no |
| <a name="input_overlay"></a> [overlay](#input\_overlay) | The overlay and options to apply. | <pre>object({<br/>    name    = string<br/>    options = optional(any)<br/>  })</pre> | `null` | no |
| <a name="input_extra_kernel_args"></a> [extra\_kernel\_args](#input\_extra\_kernel\_args) | List of extra kernel arguments that will be added as-is to the schematic<br/>configuration of `extraKernelArgs`. | `list(string)` | `[]` | no |
| <a name="input_meta"></a> [meta](#input\_meta) | Allows to set initial Talos META | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_secureboot"></a> [secureboot](#input\_secureboot) | The `secureboot` configuration, only applies to SecureBoot images. | `any` | `null` | no |
| <a name="input_architecture"></a> [architecture](#input\_architecture) | The platform architecture for which the URLs are generated. | `string` | `"amd64"` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | The platform for which the URLs are generated.<br/>One of `platform` or `sbc` must be provided. | `string` | `null` | no |
| <a name="input_sbc"></a> [sbc](#input\_sbc) | The SBC's (Single Board Computers) for which the URLs are generated.<br/>One of `platform` or `sbc` must be provided. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_talos_version"></a> [talos\_version](#output\_talos\_version) | The final Talos version that was used. |
| <a name="output_schematic"></a> [schematic](#output\_schematic) | The schematic that was generated for the configuration. |
| <a name="output_urls"></a> [urls](#output\_urls) | The urls to download artifacts. |
<!-- END_TF_DOCS -->
