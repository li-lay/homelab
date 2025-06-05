# OpenTofu

This is my OpenTofu setup with hetzner cloud provider. This code will create 3 server and 1 private network.
Upon `tofu plan || tofu apply` it will prompt for hcloud_token, default_username and user_password.

default_username value will be use for user creation in cloud-init, meaning all server will have the same user.
user_password value will be use to set the password of default_username in all server.
