resource "google_artifact_registry_repository" "harmelodic_docker" {
  provider = google-beta

  description   = "Docker repository for Harmelodic images"
  format        = "DOCKER"
  location      = var.region
  project       = google_project.artifacts.project_id
  repository_id = "harmelodic"
}
