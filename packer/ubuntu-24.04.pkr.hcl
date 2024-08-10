packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "ubuntu-server-noble-numbat" {
  proxmox_url = "${var.proxmox_api_url}"
  username    = "${var.proxmox_api_token_id}"
  token       = "${var.proxmox_api_token_secret}"

  node                 = "pve"
  vm_name              = "packer-vm-ubuntu-24.04"
  vm_id                = 999
  template_name        = "packer-ubuntu-24.04"
  template_description = "Ubuntu 24.04 LTS by Packer - Created: ${formatdate("YYYY-MM-DD hh:mm", timestamp())}"

  iso_file    = "local:iso/ubuntu-24.04-live-server-amd64.iso"
  unmount_iso = true

  bios = "seabios"
  os   = "l26"

  cores    = "1"
  cpu_type = "host"
  memory   = "2048"
  numa     = false
  sockets  = 1

  qemu_agent      = true
  scsi_controller = "virtio-scsi-single"

  disks {
    discard      = true
    disk_size    = "20G"
    format       = "raw"
    io_thread    = true
    ssd          = true
    storage_pool = "${var.storage_pool}"
    type         = "scsi"
  }

  network_adapters {
    bridge   = "vmbr1"
    firewall = "false"
    model    = "virtio"
    vlan_tag = "100"
  }

  boot_command = [
    "<esc><wait>",
    "e<wait>",
    "<down><down><down><end>",
    "<bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot_wait = "5s"
  boot      = "order=scsi0;ide2"

  http_directory = "./http"
  http_port_min  = 8738
  http_port_max  = 8738

  ssh_username = "${var.install_user_name}"
  ssh_password = "${var.install_user_password}"
  ssh_timeout  = "20m"
}

build {
  name    = "ubuntu-server-noble-numbat"
  sources = ["proxmox-iso.ubuntu-server-noble-numbat"]

  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 10; done",
      "sudo rm /etc/ssh/ssh_host_*",
      "sudo truncate -s 0 /etc/machine-id",
      "sudo rm /var/lib/dbus/machine-id",
      "sudo ln -s /etc/machine-id /var/lib/dbus/machine-id",
      "sudo apt -y autoremove --purge",
      "sudo apt -y clean",
      "sudo apt -y autoclean",
      "sudo cloud-init clean --logs",
      "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
      "sudo rm /etc/netplan/*",
      "sudo rm /etc/ssh/sshd_config.d/*",
      "sudo passwd -dl root",
      "sudo sync",
    ]
  }

  provisioner "file" {
    source      = "files/99-pve.cfg"
    destination = "/tmp/99-pve.cfg"
  }

  provisioner "shell" {
    inline = [
      "sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg",
      "sudo rm /etc/sudoers.d/90-cloud-init-users || true",
      ]
  }
}
