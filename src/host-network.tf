resource "google_compute_network" "main" {
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
  description                     = "Main VPC network for personal projects"
  name                            = "main"
  routing_mode                    = "REGIONAL"
  project                         = google_project.host.project_id
}

resource "google_compute_route" "main_default_internet_gateway" {
  dest_range       = "0.0.0.0/0"
  name             = "default-internet-gateway"
  network          = google_compute_network.main.id
  next_hop_gateway = "default-internet-gateway"
  project          = google_project.host.project_id
}
