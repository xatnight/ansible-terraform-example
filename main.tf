locals {
  disks = {
    disk01 = {
      datastore        = var.datastore
      disk_number      = 0
      interface        = var.disk_interface
      size_in_gigabyte = 30
    }
  }
  networks = {
    network01 = {
      bridge  = "vmbr1"
      model   = "virtio"
      vlan_id = 100
    }
  }
  vm_ips = flatten([for k, v in module.vms.ipv4_addresses : v])
}

module "vms" {
  source = "./modules/proxmox-vm"

  clone_vm_id          = var.clone_vm_id
  cloud_init_datastore = var.datastore
  cpu_cores            = var.core_count
  disks                = local.disks
  memory               = var.memory
  networks             = local.networks
  vm_count             = var.vm_count
  vm_name              = var.CI_PROJECT_NAME
  vm_user_keys         = var.vm_user_keys
}

resource "null_resource" "wait_for_cloudinit" {
  depends_on = [module.vms]
  provisioner "local-exec" {
    command = "sleep 240"
  }
}

data "aws_route53_zone" "this" {
  name = var.domain
}

module "rke2" {
  depends_on = [null_resource.wait_for_cloudinit]
  source     = "./modules/rke2"

  aws_zone_id        = data.aws_route53_zone.this.zone_id
  cluster_name       = var.CI_PROJECT_NAME
  domain             = var.domain
  gitlab_environment = var.CI_ENVIRONMENT_NAME
  gitlab_project_id  = var.CI_PROJECT_ID
  primary_hostname   = format("${var.CI_PROJECT_NAME}-%03d", 1)
  rke2_api_ips       = local.vm_ips
  rke2_hosts         = local.vm_ips
}

resource "local_sensitive_file" "kubeconfig" {
  filename       = "/tmp/kubeconfig"
  content_base64 = module.rke2.kubeconfig
}
