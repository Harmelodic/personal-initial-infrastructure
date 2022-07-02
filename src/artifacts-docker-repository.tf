resource "google_artifact_registry_repository" "docker" {
  provider = google-beta

  description   = "Docker repository for Personal images"
  format        = "DOCKER"
  project       = google_project.artifacts.project_id
  repository_id = "personal"
}
