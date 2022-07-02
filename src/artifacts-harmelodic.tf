resource "google_artifact_registry_repository" "harmelodic_docker" {
  provider = google-beta

  description   = "Docker repository for Harmelodic images"
  format        = "DOCKER"
  location      = var.region
  project       = google_project.artifacts.project_id
  repository_id = "harmelodic"
}

resource "google_artifact_registry_repository_iam_member" "gke_service_account" {
  provider   = google-beta
  project    = google_artifact_registry_repository.harmelodic_docker.project
  location   = google_artifact_registry_repository.harmelodic_docker.location
  repository = google_artifact_registry_repository.harmelodic_docker.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_project.apps.number}@cloudservices.gserviceaccount.com"
}
