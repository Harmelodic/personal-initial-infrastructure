resource "kubernetes_namespace" "harmelodic" {
  metadata {
    name = "harmelodic"
  }
}

module "harmelodic_website_workload" {
  source     = "./workload"
  name       = "website"
  namespace  = kubernetes_namespace.harmelodic.metadata.0.name
  project_id = google_project.apps.project_id
}

resource "google_artifact_registry_repository_iam_member" "gke_service_account" {
  provider   = google-beta
  project    = google_artifact_registry_repository.harmelodic_docker.project
  location   = google_artifact_registry_repository.harmelodic_docker.location
  repository = google_artifact_registry_repository.harmelodic_docker.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${module.harmelodic_website_workload.google_service_account.email}",
}
