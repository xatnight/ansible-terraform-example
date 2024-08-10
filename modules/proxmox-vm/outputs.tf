output "ipv4_addresses" {
  value = { for index in range(var.vm_count) : format("${var.vm_name}-%03d", index + 1) =>
    [for ip in flatten(proxmox_virtual_environment_vm.vm[index].ipv4_addresses) : ip if startswith(ip, "192.168")]
  }
}
