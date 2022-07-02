resource "google_compute_firewall" "http-allow" {
  name    = "http-ingress-rule"
  network = google_compute_network.main.name
  project = google_project.host.project_id

  allow {
    protocol = "tcp"
    ports = [
      "80",
      "443"
    ]
  }

  source_ranges = [
    "0.0.0.0/0"
  ]
}
