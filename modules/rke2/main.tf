resource "aws_route53_record" "rke2" {
  zone_id = var.aws_zone_id
  name    = var.cluster_name
  type    = "A"
  ttl     = 300
  records = var.rke2_api_ips
}

resource "random_password" "rke2_token" {
  count   = var.rke2_ha == true ? 1 : 0
  length  = 32
  special = false
}

resource "null_resource" "ansible" {
  triggers = {
    "build" = timestamp()
  }
  provisioner "ansible" {
    plays {
      vault_password_file = "~/vault"
      playbook {
        file_path  = "${path.root}/ansible/playbook.yml"
        roles_path = ["${path.root}/ansible/roles"]
      }
      extra_vars = {
        cluster_name     = var.cluster_name
        primary_hostname = var.primary_hostname
        rke2_domain      = var.domain
        rke2_fqdn        = aws_route53_record.rke2.fqdn
        rke2_ha          = var.rke2_ha
        rke2_token       = var.rke2_ha == true ? random_password.rke2_token[0].result : ""
      }
      verbose = true
      hosts   = var.rke2_hosts
    }
    ansible_ssh_settings {
      insecure_no_strict_host_key_checking = true
    }
  }
}

resource "kubectl_manifest" "rke2_helm_config" {
  depends_on = [null_resource.ansible]
  yaml_body = templatefile("${path.module}/manifests/rke2.yaml", {
    ingress_metrics    = var.ingress_metrics
    use_proxy_protocol = var.use_proxy_protocol
  })
}

data "local_file" "kubeconfig" {
  depends_on = [
    null_resource.ansible,
  ]
  filename = "/root/.kube/${var.cluster_name}"
}

resource "gitlab_project_variable" "kubeconfig" {
  project           = var.gitlab_project_id
  key               = "KUBE_CONFIG"
  value             = data.local_file.kubeconfig.content_base64
  masked            = true
  environment_scope = var.gitlab_environment
}
