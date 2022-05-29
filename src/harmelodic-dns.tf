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
  name        = var.harmelodic_domain_name

  labels = {
    environment = terraform.workspace
  }
}
