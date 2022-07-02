resource "google_artifact_registry_repository" "harmelodic_docker" {
  provider = google-beta

  description   = "Docker repository for Harmelodic images"
  format        = "DOCKER"
  location      = var.region
  project       = google_project.artifacts.project_id
  repository_id = "harmelodic"
}

resource "google_artifact_registry_repository_iam_member" "gke_node_service_agent" {
  provider   = google-beta
  project    = google_artifact_registry_repository.harmelodic_docker.project
  location   = google_artifact_registry_repository.harmelodic_docker.location
  repository = google_artifact_registry_repository.harmelodic_docker.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:service-${google_project.apps.number}@container-engine-robot.iam.gserviceaccount.com"
}
