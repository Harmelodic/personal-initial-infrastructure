module "cert_manager_workload" {
  source     = "./workload"
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata.0.name
  project_id = google_project.apps.project_id
}

resource "google_project_iam_member" "cert_manager" {
  for_each = toset([
    "roles/dns.admin"
  ])

  member  = "serviceAccount:${module.cert_manager_workload.google_service_account.email}"
  project = google_project.host.project_id
  role    = each.key
}
