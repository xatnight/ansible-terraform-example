resource "random_password" "vm_user" {
  count   = var.vm_user_password == "" ? 1 : 0
  length  = 24
  special = false
}

resource "proxmox_virtual_environment_vm" "vm" {
  count           = var.vm_count
  pool_id         = var.pool_id
  bios            = var.bios
  description     = var.description
  machine         = var.machine_type
  name            = format("${var.vm_name}-%03d", count.index + 1)
  node_name       = var.target_node
  on_boot         = var.on_boot
  reboot          = var.reboot
  scsi_hardware   = var.scsi_hardware
  keyboard_layout = var.keyboard_layout

  clone {
    retries = var.clone_retries
    vm_id   = var.clone_vm_id
  }

  agent {
    enabled = var.agent
  }

  cpu {
    cores   = var.cpu_cores
    numa    = var.numa
    sockets = var.cpu_sockets
    type    = var.cpu_type
    units   = var.cpu_units
  }

  memory {
    dedicated = var.memory
    floating  = var.memory
  }

  dynamic "disk" {
    for_each = var.disks
    content {
      cache        = disk.value["cache"]
      datastore_id = disk.value["datastore"]
      discard      = disk.value["discard"]
      file_format  = disk.value["file_format"]
      interface    = "${disk.value["interface"]}${disk.value["disk_number"]}"
      iothread     = disk.value["iothread"]
      size         = disk.value["size_in_gigabyte"]
      ssd          = disk.value["ssd"]
    }
  }

  dynamic "network_device" {
    for_each = var.networks
    content {
      bridge   = network_device.value["bridge"]
      firewall = network_device.value["firewall"]
      model    = network_device.value["model"]
      vlan_id  = network_device.value["vlan_id"]
    }
  }

  initialization {
    datastore_id = var.cloud_init_datastore
    ip_config {
      ipv4 {
        address = "dhcp"
      }
      ipv6 {
        address = "dhcp"
      }
    }
    user_account {
      keys     = var.vm_user_keys
      username = var.vm_user_name
      password = var.vm_user_password != "" ? var.vm_user_password : random_password.vm_user[0].result
    }
  }

  operating_system {
    type = var.os_type
  }

  lifecycle {
    ignore_changes = [
      initialization,
      machine
    ]
  }
}
