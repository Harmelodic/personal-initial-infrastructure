#resource "google_compute_subnetwork" "apps" {
#  project       = google_project.apps_project.project_id
#  name          = "apps"
#  description   = "Subnetwork for applications"
#  region        = var.region
#  network       = google_compute_network.main.id
#  ip_cidr_range = "10.0.0.0/16"
#  private_ip_google_access = true
#
#  log_config {
#
#  }
#
#  secondary_ip_range {
#    range_name    = "pod-range"
#    ip_cidr_range = "10.1.0.0/16"
#  }
#
#  secondary_ip_range {
#    range_name    = "service-range"
#    ip_cidr_range = "10.2.0.0/16"
#  }
#}
