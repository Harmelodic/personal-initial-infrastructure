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
