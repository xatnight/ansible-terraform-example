variable "install_user_name" {
  default = env("INSTALL_USER_NAME")
  type    = string
}

variable "install_user_password" {
  default   = env("INSTALL_USER_PASSWORD")
  sensitive = true
  type      = string
}

variable "proxmox_api_token_id" {
  default = env("PROXMOX_API_TOKEN_ID")
  type    = string
}

variable "proxmox_api_token_secret" {
  default   = env("PROXMOX_API_TOKEN")
  sensitive = true
  type      = string
}

variable "proxmox_api_url" {
  default = env("PROXMOX_API_URL")
  type    = string
}

variable "storage_pool" {
  default = "nvme-vmdata"
  type    = string
}
