provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "gitlab" {
  source          = "modules/gitlab"
  vm_name         = "${var.gitlab_vm_name}"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  gitlab_disk_image  = "${var.disk_image}"
}

module "gitlab-runners" {
  source          = "modules/gitlab-runners"
  prod_name       = "${var.prod_vm_name}"
  dev_name        = "${var.dev_vm_name}"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  vm_disk_image   = "${var.disk_image}"
}

module "vpc" {
  source        = "modules/vpc"
  source_ranges = "${var.ip_range}"
}
