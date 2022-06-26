variable "apps_harmelodic_dns_name" {
  description = "Harmelodic domain name used for this environment"
  sensitive   = true
  type        = string
}

resource "google_dns_managed_zone" "harmelodic_com" {
  depends_on = [
    google_project_service.host_apis
  ]

  description = "Managed Zone for ${var.apps_harmelodic_dns_name}"
  dns_name    = "${var.apps_harmelodic_dns_name}."
  name        = replace(var.apps_harmelodic_dns_name, ".", "-")
  project     = google_project.host.project_id

  labels = {
    environment = terraform.workspace
  }
}
