output "gitlab_external_ip" {
  value = "${module.gitlab.gitlab_external_ip}"
}

output "dev_external_ip" {
  value = "${module.gitlab-runners.dev_external_ip}"
}

output "prod_external_ip" {
  value = "${module.gitlab-runners.prod_external_ip}"
}
