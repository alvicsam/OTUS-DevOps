variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable vm_disk_image {
  description = "Disk image with docker"
  default     = "crawler-base"
}

variable prod_name {
  description = "Instance Name"
  default     = "prod"
}

variable dev_name {
  description = "Instance Name"
  default     = "dev"
}
