variable source_ranges {
  description = "Allowed IP addresses"
  default     = ["0.0.0.0/0"]
}

variable app_ports {
  description = "Allowed ports"
  default     = ["15672", "8000"]
}

variable gitlab_ports {
  description = "Allowed ports"
  default     = ["80"]
}
