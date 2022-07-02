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

resource "google_project_iam_member" "harmelodic_website" {
  project    = google_project.artifacts.project_id
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${module.harmelodic_website_workload.google_service_account.email}"
}
