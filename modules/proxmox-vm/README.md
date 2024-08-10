# proxmox vm module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_vm.vm](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |
| [random_password.vm_user](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent"></a> [agent](#input\_agent) | Enable/disable QEMU guest agent | `bool` | `true` | no |
| <a name="input_bios"></a> [bios](#input\_bios) | Typo of BIOS to use | `string` | `"seabios"` | no |
| <a name="input_clone_retries"></a> [clone\_retries](#input\_clone\_retries) | Amount of retries for cloning | `number` | `2` | no |
| <a name="input_clone_vm_id"></a> [clone\_vm\_id](#input\_clone\_vm\_id) | VM id to clone from | `number` | n/a | yes |
| <a name="input_cloud_init_datastore"></a> [cloud\_init\_datastore](#input\_cloud\_init\_datastore) | Datastore for the cloud-init datadisk | `string` | n/a | yes |
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | Number of CPU cores | `number` | n/a | yes |
| <a name="input_cpu_sockets"></a> [cpu\_sockets](#input\_cpu\_sockets) | Number of CPU sockets | `number` | `1` | no |
| <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type) | CPU type, see https://pve.proxmox.com/pve-docs/chapter-qm.html#qm_cpu | `string` | `"host"` | no |
| <a name="input_cpu_units"></a> [cpu\_units](#input\_cpu\_units) | Weigth for cpu time, see https://pve.proxmox.com/pve-docs/chapter-qm.html#qm_cpu | `number` | `100` | no |
| <a name="input_description"></a> [description](#input\_description) | Optional description for VM | `string` | `"VM created by terraform"` | no |
| <a name="input_disks"></a> [disks](#input\_disks) | Map of disks, see https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#disk | <pre>map(object({<br>    cache            = optional(string, "none")<br>    datastore        = string<br>    discard          = optional(string, "on")<br>    disk_number      = number<br>    file_format      = optional(string, "raw")<br>    interface        = string<br>    iothread         = optional(bool, true)<br>    size_in_gigabyte = string<br>    ssd              = optional(bool, true)<br>  }))</pre> | n/a | yes |
| <a name="input_keyboard_layout"></a> [keyboard\_layout](#input\_keyboard\_layout) | de | `string` | `"Keyboard layout for the VM"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | VM machine type, see https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#machine | `string` | `"pc"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of RAM | `number` | n/a | yes |
| <a name="input_networks"></a> [networks](#input\_networks) | Map of network devices, see https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#network_device | <pre>map(object({<br>    bridge   = string<br>    firewall = optional(bool, false)<br>    model    = optional(string, "virtio")<br>    vlan_id  = optional(number, null)<br>  }))</pre> | n/a | yes |
| <a name="input_numa"></a> [numa](#input\_numa) | Enable/disable numa for multi socket systems | `bool` | `false` | no |
| <a name="input_on_boot"></a> [on\_boot](#input\_on\_boot) | Enable/disable powering up the VM on boot | `bool` | `true` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | OS type, see https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#operating_system | `string` | `"l26"` | no |
| <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id) | Name of the pool to assign the VM to | `string` | `"terraform"` | no |
| <a name="input_reboot"></a> [reboot](#input\_reboot) | Reboot VM after initial creation | `bool` | `true` | no |
| <a name="input_scsi_hardware"></a> [scsi\_hardware](#input\_scsi\_hardware) | Disk controller type, see https://pve.proxmox.com/pve-docs/chapter-qm.html#qm_hard_disk | `string` | `"virtio-scsi-single"` | no |
| <a name="input_target_node"></a> [target\_node](#input\_target\_node) | Name of the proxmox node on which the VMs will be created | `string` | `"pve"` | no |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | Number of VMs to create | `number` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name of the VM | `string` | n/a | yes |
| <a name="input_vm_user_keys"></a> [vm\_user\_keys](#input\_vm\_user\_keys) | SSH public keys for the VM user | `set(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_vm_user_name"></a> [vm\_user\_name](#input\_vm\_user\_name) | Name for the VM user | `string` | `"terraform"` | no |
| <a name="input_vm_user_password"></a> [vm\_user\_password](#input\_vm\_user\_password) | Password for the VM user, empty value generates one | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4_addresses"></a> [ipv4\_addresses](#output\_ipv4\_addresses) | n/a |
<!-- END_TF_DOCS -->
