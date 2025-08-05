variable "passphrase" {
  description = "Passphrase use to encrypt state files"
  type        = string
  sensitive   = true
}

variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "ssh_key_name" {
  description = "The name of SSH key in Hetzner Cloud"
  type        = string
  default     = "homelab-ssh-key"
}

variable "ssh_public_key_path" {
  description = "The path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "default_username" {
  description = "Set default username for all nodes"
  type        = string
  sensitive   = false
}

variable "hashed_password" {
  description = "Set user password for all nodes, [only support hashed password]"
  type        = string
  sensitive   = false
}
