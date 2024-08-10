output "kubeconfig" {
  description = "Kubectl config (base64)"
  value       = data.local_file.kubeconfig.content_base64
}

output "rke2_fqdn" {
  description = "Hostname at which rke2 will be available"
  value       = aws_route53_record.rke2.fqdn
}
