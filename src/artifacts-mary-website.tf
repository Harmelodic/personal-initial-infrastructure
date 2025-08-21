resource "google_artifact_registry_repository" "mary_website_docker" {
  # checkov:skip=CKV_GCP_84: TODO: Review need for CSEK / CMEK
  description   = "Docker repository for Mary Website images"
  format        = "DOCKER"
  location      = "asia-southeast1"
  project       = google_project.artifacts.project_id
  repository_id = "mary-website"
}
