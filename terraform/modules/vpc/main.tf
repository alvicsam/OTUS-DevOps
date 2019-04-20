resource "google_compute_firewall" "firewall_ssh" {
  name          = "allow-ssh"
  network       = "default"
  source_ranges = "${var.source_ranges}"
  target_tags   = ["gitlab", "dev", "prod"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "firewall_app" {
  name          = "allow-app-ports"
  network       = "default"
  source_ranges = "${var.source_ranges}"
  target_tags   = ["dev", "prod"]

  allow {
    protocol = "tcp"
    ports    = "${var.app_ports}"
  }
}

resource "google_compute_firewall" "firewall_gitlab" {
  name          = "allow-gitlab-http"
  network       = "default"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gitlab"]

  allow {
    protocol = "tcp"
    ports    = "${var.gitlab_ports}"
  }
}
