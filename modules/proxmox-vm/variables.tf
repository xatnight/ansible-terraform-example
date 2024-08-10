variable "agent" {
  default     = true
  description = "Enable/disable QEMU guest agent"
  type        = bool
}

variable "bios" {
  default     = "seabios"
  description = "Typo of BIOS to use"
  type        = string
}

variable "clone_retries" {
  description = "Amount of retries for cloning"
  default     = 2
  type        = number
}

variable "clone_vm_id" {
  description = "VM id to clone from"
  type        = number
}

variable "cloud_init_datastore" {
  description = "Datastore for the cloud-init datadisk"
  type        = string
}

variable "cpu_cores" {
  description = "Number of CPU cores"
  type        = number
}

variable "cpu_sockets" {
  description = "Number of CPU sockets"
  type        = number
  default     = 1
}

variable "cpu_type" {
  default     = "host"
  description = "CPU type, see https://pve.proxmox.com/pve-docs/chapter-qm.html#qm_cpu"
  type        = string
}

variable "cpu_units" {
  default     = 100
  description = "Weigth for cpu time, see https://pve.proxmox.com/pve-docs/chapter-qm.html#qm_cpu"
  type        = number
}

variable "description" {
  default     = "VM created by terraform"
  description = "Optional description for VM"
  type        = string
}

variable "disks" {
  description = "Map of disks, see https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#disk"
  type = map(object({
    cache            = optional(string, "none")
    datastore        = string
    discard          = optional(string, "on")
    disk_number      = number
    file_format      = optional(string, "raw")
    interface        = string
    iothread         = optional(bool, true)
    size_in_gigabyte = string
    ssd              = optional(bool, true)
  }))

  validation {
    condition = alltrue([
      for object in var.disks :
      contains(["on", "off"], object.discard)
      ]
    )
    error_message = "Discard value must be on(default) or off"
  }

  validation {
    condition = alltrue([
      for object in var.disks :
      contains(["none", "directsync", "writethrough", "writeback", "unsafe"], object.cache)
      ]
    )
    error_message = "Cache must be one off: none(default) directsync writethrough writeback unsafe"
  }

  validation {
    condition = alltrue([
      for object in var.disks :
      contains(["scsi", "sata", "virtio"], object.interface)
      ]
    )
    error_message = "Interface must be one off: scsi sata virtio"
  }

  validation {
    condition = alltrue([
      for object in var.disks :
      contains(["raw", "qcow2", "vmdk"], object.file_format)
      ]
    )
    error_message = "File format must be one off: raw(default) qcow2 vmdk"
  }
}

variable "keyboard_layout" {
  default     = "Keyboard layout for the VM"
  description = "de"
  type        = string
}

variable "machine_type" {
  default     = "pc"
  description = "VM machine type, see https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#machine"
  type        = string
}

variable "memory" {
  description = "Amount of RAM"
  type        = number
}

variable "networks" {
  description = "Map of network devices, see https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#network_device"
  type = map(object({
    bridge   = string
    firewall = optional(bool, false)
    model    = optional(string, "virtio")
    vlan_id  = optional(number, null)
  }))
}

variable "numa" {
  default     = false
  description = "Enable/disable numa for multi socket systems"
  type        = bool
}

variable "on_boot" {
  default     = true
  description = "Enable/disable powering up the VM on boot"
  type        = bool
}

variable "os_type" {
  default     = "l26"
  description = "OS type, see https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#operating_system"
  type        = string
}

variable "pool_id" {
  default     = "terraform"
  description = "Name of the pool to assign the VM to"
  type        = string
}

variable "reboot" {
  default     = true
  description = "Reboot VM after initial creation"
  type        = bool
}

variable "scsi_hardware" {
  default     = "virtio-scsi-single"
  description = "Disk controller type, see https://pve.proxmox.com/pve-docs/chapter-qm.html#qm_hard_disk"
  type        = string
}

variable "target_node" {
  default     = "pve"
  description = "Name of the proxmox node on which the VMs will be created"
  type        = string
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "vm_user_keys" {
  description = "SSH public keys for the VM user"
  type        = set(string)
  default     = [""]
}

variable "vm_user_name" {
  description = "Name for the VM user"
  type        = string
  default     = "terraform"
}

variable "vm_user_password" {
  description = "Password for the VM user, empty value generates one"
  type        = string
  default     = ""
}
