output "node-1_ipv4" {
  description = "Public IPv4 address of Node-1"
  value       = hcloud_server.node-1.ipv4_address
}

output "default_username" {
   description = "Default username for cloud-init"
   value = var.default_username
}

output "user_password" {
   description = "Default user password for cloud-init"
   value = var.user_password
}
