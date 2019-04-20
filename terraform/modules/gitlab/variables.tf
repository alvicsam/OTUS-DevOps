variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable gitlab_disk_image {
  description = "Disk image with docker and docker-compose installed"
  default     = "crawler-base"
}

variable vm_name {
  description = "Instance Name"
  default     = "gitlab"
}
