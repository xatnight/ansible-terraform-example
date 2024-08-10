provider "proxmox" {}

provider "aws" {}

provider "kubectl" {
  config_path = local_sensitive_file.kubeconfig.filename
}

provider "gitlab" {}
