resource "google_compute_instance" "dev" {
  name         = "${var.dev_name}"
  machine_type = "n1-standard-1"
  zone         = "${var.zone}"
  tags         = ["dev"]

  boot_disk {
    initialize_params {
      image = "${var.vm_disk_image}"
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

resource "google_compute_instance" "prod" {
  name         = "${var.prod_name}"
  machine_type = "n1-standard-1"
  zone         = "${var.zone}"
  tags         = ["prod"]

  boot_disk {
    initialize_params {
      image = "${var.vm_disk_image}"
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
