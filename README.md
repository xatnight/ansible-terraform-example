# ansible-terraform-example

## Overview

Small example how I setup VMs for use with [rke2](https://docs.rke2.io/) on proxmox via [packer](https://www.packer.io/) (build base image to clone), terraform (create VM and run ansible), ansible (setup the host, users, firewall, install rke2). This code is actually hosted on gitlab (self hosted) and executed via gitlab runner (with the docker executor), thus the dockerfiles and ci files to build them as additional examples. Stuff like secrets and passwords all come from gitlab as CI/CD variables.

Ansible vault password is 1234

### Terraform Modules

README (providers, inputs, resources, outputs) for modules provided in their respective folders. The rke2 module uses the [ansible provisioner](https://github.com/radekg/terraform-provisioner-ansible) to install rke2, see the [terraform dockerfile](./docker/terraform/dockerfile) how to install it.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rke2"></a> [rke2](#module\_rke2) | ./modules/rke2 | n/a |
| <a name="module_vms"></a> [vms](#module\_vms) | ./modules/proxmox-vm | n/a |

## Resources

| Name | Type |
|------|------|
| [local_sensitive_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [null_resource.wait_for_cloudinit](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CI_ENVIRONMENT_NAME"></a> [CI\_ENVIRONMENT\_NAME](#input\_CI\_ENVIRONMENT\_NAME) | n/a | `any` | n/a | yes |
| <a name="input_CI_PROJECT_ID"></a> [CI\_PROJECT\_ID](#input\_CI\_PROJECT\_ID) | n/a | `any` | n/a | yes |
| <a name="input_CI_PROJECT_NAME"></a> [CI\_PROJECT\_NAME](#input\_CI\_PROJECT\_NAME) | n/a | `any` | n/a | yes |
| <a name="input_clone_vm_id"></a> [clone\_vm\_id](#input\_clone\_vm\_id) | n/a | `number` | `999` | no |
| <a name="input_core_count"></a> [core\_count](#input\_core\_count) | n/a | `number` | `4` | no |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | n/a | `string` | `"vmdata"` | no |
| <a name="input_disk_interface"></a> [disk\_interface](#input\_disk\_interface) | n/a | `string` | `"scsi"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | `"example.com"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `number` | `8192` | no |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | n/a | `number` | `1` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | n/a | `string` | `"rke2-example"` | no |
| <a name="input_vm_user_keys"></a> [vm\_user\_keys](#input\_vm\_user\_keys) | n/a | `list` | <pre>[<br>  "from=\"192.168.100.46/32\" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYhTH5cDbWfGs1Bfbaaar/n4Xh2XdfywEEoF54ermZ3 automation"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
