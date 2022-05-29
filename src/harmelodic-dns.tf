variable "harmelodic_domain_name" {
  description = "Harmelodic domain name used for this environment"
  sensitive   = true
  type        = string
}

resource "google_dns_managed_zone" "harmelodic_com" {
  depends_on = [
    google_project_service.host_apis
  ]

  description = "Managed Zone for ${var.harmelodic_domain_name}"
  dns_name    = var.harmelodic_domain_name
  name        = replace(var.harmelodic_domain_name, ".", "-")
  project     = google_project.host.project_id

  labels = {
    environment = terraform.workspace
  }
}
