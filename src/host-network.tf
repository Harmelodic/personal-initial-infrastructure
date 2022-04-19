resource "google_compute_network" "main" {
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
  description                     = "Main VPC network for personal projects"
  name                            = "main"
  routing_mode                    = "REGIONAL"
  project                         = google_project.host.project_id
}
