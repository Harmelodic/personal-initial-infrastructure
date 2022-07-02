resource "google_service_account" "cert_manager" {
  project    = google_project.apps.project_id
  account_id = "cert-manager"
}

resource "google_project_iam_member" "cert_manager" {
  for_each = toset([
    "roles/dns.admin"
  ])

  member  = "serviceAccount:${google_service_account.cert_manager.email}"
  project = google_project.host.project_id
  role    = each.key
}

resource "kubernetes_service_account" "cert_manager" {
  metadata {
    name      = "cert-manager"
    namespace = kubernetes_namespace.cert_manager.metadata.0.name

    annotations = {
      "iam.gke.io/gcp-service-account" = "cert-manager@${google_project.apps.project_id}.iam.gserviceaccount.com"
    }
  }
}


resource "google_service_account_iam_member" "cert_manager_workload_identity" {
  member             = "serviceAccount:${google_project.apps.project_id}.svc.id.goog[${kubernetes_service_account.cert_manager.metadata.0.namespace}/${kubernetes_service_account.cert_manager.metadata.0.name}]"
  project            = google_project.apps.project_id
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.cert_manager.name
}
