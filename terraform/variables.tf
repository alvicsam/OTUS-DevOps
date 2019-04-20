variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable private_key_path {
  description = "Path to the public key used for ssh access"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable gitlab_vm_name {
  description = "Gitlab instance name"
  default     = "gitlab"
}

variable prod_vm_name {
  description = "Production instance name"
  default     = "prod"
}

variable dev_vm_name {
  description = "Development stand instance name"
  default     = "dev"
}

variable disk_image {
  description = "Disk image with docker"
  default     = "crawler-base"
}

variable ip_range {
  description = "ip accedd range"
  default     = ["0.0.0.0/0"]
}
