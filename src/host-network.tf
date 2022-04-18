#resource "google_compute_network" "main" {
#  project                         = google_project.host.project_id
#  description                     = "Main VPC network for personal projects"
#  routing_mode                    = "REGIONAL"
#  name                            = "main"
#  auto_create_subnetworks         = false
#  delete_default_routes_on_create = true
#}
