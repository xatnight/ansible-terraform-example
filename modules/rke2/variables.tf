variable "aws_zone_id" {
  type        = string
  description = "Zone ID for the route53 records"
}

variable "cluster_name" {
  type        = string
  description = "Identifier for the cluster"
}

variable "domain" {
  type        = string
  description = "Domain to use for dns entry for rke2 api"
}

variable "gitlab_environment" {
  type        = string
  description = "Environment scope for the project variable"
}

variable "gitlab_project_id" {
  type        = number
  description = "ID of the gitlab project to upload base64 kubeconfig to"
}

variable "ingress_metrics" {
  type        = bool
  description = "Enable/disable ingress metric creation"
  default     = false
}

variable "primary_hostname" {
  type        = string
  description = "Hostname of the primary node on which rke2 will be started first for the other nodes register to"
}

variable "rke2_api_ips" {
  type        = set(string)
  description = "IP address(es) that serves rke2 requests (api and registration)"
}

variable "rke2_ha" {
  type        = bool
  default     = false
  description = "Enable/disable rke2 HA setup"
}

variable "rke2_hosts" {
  type        = set(string)
  description = "IP address(es) of the rke2 nodes"
}

variable "use_proxy_protocol" {
  type        = bool
  description = "Enable/disable proxy protocol for ingress"
  default     = false
}
