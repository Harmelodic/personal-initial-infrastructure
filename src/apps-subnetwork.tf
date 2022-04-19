locals {
  cluster_secondary_range_name  = "pods-secondary-range"
  services_secondary_range_name = "services-secondary-range"
}

resource "google_compute_subnetwork" "apps" {
  depends_on = [
    google_compute_shared_vpc_service_project.apps
  ]

  description              = "Subnetwork for applications"
  ip_cidr_range            = "10.0.0.0/16"
  name                     = "apps"
  private_ip_google_access = true
  project                  = google_project.host.project_id
  network                  = google_compute_network.main.id
  region                   = var.region

  secondary_ip_range {
    ip_cidr_range = "10.1.0.0/16"
    range_name    = local.cluster_secondary_range_name
  }

  secondary_ip_range {
    ip_cidr_range = "10.2.0.0/16"
    range_name    = local.services_secondary_range_name
  }
}
