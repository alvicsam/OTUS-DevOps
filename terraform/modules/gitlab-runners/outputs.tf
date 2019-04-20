output "prod_external_ip" {
  value = "${google_compute_instance.prod.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "dev_external_ip" {
  value = "${google_compute_instance.dev.network_interface.0.access_config.0.assigned_nat_ip}"
}
