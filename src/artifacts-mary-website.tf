resource "google_artifact_registry_repository" "mary_website_docker" {
  description   = "Docker repository for Mary Website images"
  format        = "DOCKER"
  location      = "asia-southeast1"
  project       = google_project.artifacts.project_id
  repository_id = "mary-website"
}
