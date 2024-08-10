terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
    acme = {
      source = "vancluever/acme"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
    }
  }
}
