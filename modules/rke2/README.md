# rke2 module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.rke2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [gitlab_project_variable.kubeconfig](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_variable) | resource |
| [kubectl_manifest.rke2_helm_config](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [null_resource.ansible](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.rke2_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_zone_id"></a> [aws\_zone\_id](#input\_aws\_zone\_id) | Zone ID for the route53 records | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Identifier for the cluster | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain to use for dns entry for rke2 api | `string` | n/a | yes |
| <a name="input_gitlab_environment"></a> [gitlab\_environment](#input\_gitlab\_environment) | Environment scope for the project variable | `string` | n/a | yes |
| <a name="input_gitlab_project_id"></a> [gitlab\_project\_id](#input\_gitlab\_project\_id) | ID of the gitlab project to upload base64 kubeconfig to | `number` | n/a | yes |
| <a name="input_ingress_metrics"></a> [ingress\_metrics](#input\_ingress\_metrics) | Enable/disable ingress metric creation | `bool` | `false` | no |
| <a name="input_primary_hostname"></a> [primary\_hostname](#input\_primary\_hostname) | Hostname of the primary node on which rke2 will be started first for the other nodes register to | `string` | n/a | yes |
| <a name="input_rke2_api_ips"></a> [rke2\_api\_ips](#input\_rke2\_api\_ips) | IP address(es) that serves rke2 requests (api and registration) | `set(string)` | n/a | yes |
| <a name="input_rke2_ha"></a> [rke2\_ha](#input\_rke2\_ha) | Enable/disable rke2 HA setup | `bool` | `false` | no |
| <a name="input_rke2_hosts"></a> [rke2\_hosts](#input\_rke2\_hosts) | IP address(es) of the rke2 nodes | `set(string)` | n/a | yes |
| <a name="input_use_proxy_protocol"></a> [use\_proxy\_protocol](#input\_use\_proxy\_protocol) | Enable/disable proxy protocol for ingress | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | Kubectl config (base64) |
| <a name="output_rke2_fqdn"></a> [rke2\_fqdn](#output\_rke2\_fqdn) | Hostname at which rke2 will be available |
<!-- END_TF_DOCS -->
