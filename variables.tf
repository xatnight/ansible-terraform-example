variable "CI_ENVIRONMENT_NAME" {}

variable "CI_PROJECT_ID" {}

variable "CI_PROJECT_NAME" {}

variable "clone_vm_id" {
  default = 999
}

variable "core_count" {
  default = 4
}

variable "datastore" {
  default = "vmdata"
}

variable "disk_interface" {
  default = "scsi"
}

variable "domain" {
  default = "example.com"
}

variable "memory" {
  default = 8192
}

variable "vm_count" {
  default = 1
}

variable "vm_name" {
  default = "rke2-example"
}

variable "vm_user_keys" {
  default = ["from=\"192.168.100.46/32\" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYhTH5cDbWfGs1Bfbaaar/n4Xh2XdfywEEoF54ermZ3 automation"]
}
