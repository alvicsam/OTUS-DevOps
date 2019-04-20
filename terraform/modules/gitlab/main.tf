resource "google_compute_instance" "gitlab" {
  name         = "${var.vm_name}"
  machine_type = "n1-standard-1"
  zone         = "${var.zone}"
  tags         = ["gitlab"]

  boot_disk {
    initialize_params {
      size  = 30
      image = "${var.gitlab_disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}
