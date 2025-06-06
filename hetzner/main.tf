#=========================================================#
#OpenTofu for creating a server on Hetzner via hcloud api!#
#=========================================================#

terraform {
  encryption {
    key_provider "pbkdf2" "mykey" {
      passphrase = var.passphrase
    }
    method "aes_gcm" "mymethod" {
      keys = key_provider.pbkdf2.mykey
    }
    state {
      method = method.aes_gcm.mymethod
    }
  }
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.51.0"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

# Define your SSH Key
resource "hcloud_ssh_key" "default" {
  name       = var.ssh_key_name
  public_key = file(var.ssh_public_key_path)
}

# Cloud-init configuration for user setup and root disablement
# This template is used by all servers
locals {
  cloud_init_config = <<-EOT
    #cloud-config
    users:
      - name: ${var.default_username}
        ssh_authorized_keys:
          - ${file(var.ssh_public_key_path)}
        sudo: ALL=(ALL) ALL
        groups: users,sudo,docker # Add docker group if you plan to install docker
        shell: /bin/bash

    # Change passwords for user using chpasswd
    chpasswd:
      expire: false
      users:
      - {name: ${var.default_username}, password: ${var.hashed_password}}
    
    disable_root: true # Disable root login
    ssh_pwauth: false # Disable SSH password authentication

    package_update: true
    package_upgrade: true
  EOT
}

# Create Cloud Server
resource "hcloud_server" "node-1" {
  name        = "node-1"
  image       = "debian-12"
  server_type = "ccx13"
  location    = "fsn1"
  ssh_keys    = [hcloud_ssh_key.default.id]
  user_data = local.cloud_init_config
}
