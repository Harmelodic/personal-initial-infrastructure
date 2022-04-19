locals {
  cluster_secondary_range_name  = "pods-secondary-range"
  services_secondary_range_name = "services-secondary-range"
}

resource "google_compute_subnetwork" "apps" {
  project       = google_project.apps.project_id
  name          = "apps"
  description   = "Subnetwork for applications"
  region        = var.region
  network       = google_compute_network.main.id
  ip_cidr_range = "10.0.0.0/16"
  private_ip_google_access = true

  log_config {

  }

  secondary_ip_range {
    range_name    = local.cluster_secondary_range_name
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = local.services_secondary_range_name
    ip_cidr_range = "10.2.0.0/16"
  }
}
