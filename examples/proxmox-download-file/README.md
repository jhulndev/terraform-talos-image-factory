<!-- BEGIN_TF_DOCS -->
# Proxmox Download File Example

Source Usage: [root](../../)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.8 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.73 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | ~> 0.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | ~> 0.73 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_talos_image_factory"></a> [talos\_image\_factory](#module\_talos\_image\_factory) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_download_file.talos_image](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pve_node_name"></a> [pve\_node\_name](#input\_pve\_node\_name) | The Proxmox node that will be used to download the image. | `string` | n/a | yes |
| <a name="input_pve_datastore_id"></a> [pve\_datastore\_id](#input\_pve\_datastore\_id) | The Proxmox datastore id that the image will be downloaded to. | `string` | `"local"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pve_file_id"></a> [pve\_file\_id](#output\_pve\_file\_id) | The disk image to use to boot Proxmox VMs. |
| <a name="output_installer"></a> [installer](#output\_installer) | Use this installer image for upgrades. |
<!-- END_TF_DOCS -->
