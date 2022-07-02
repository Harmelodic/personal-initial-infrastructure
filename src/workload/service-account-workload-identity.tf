variable "name" {
  description = "Name of the Workload"
  type        = string
}

resource "google_service_account" "workload" {
  project    = data.google_project.target.project_id
  account_id = var.name
}

resource "kubernetes_service_account" "workload" {
  metadata {
    name      = var.name
    namespace = data.kubernetes_namespace.target.metadata.0.name

    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.workload.email
    }
  }
}

resource "google_service_account_iam_member" "cert_manager_workload_identity" {
  member = concat([
    "serviceAccount:",
    data.google_project.target.project_id,
    ".svc.id.goog[",
    kubernetes_service_account.workload.metadata.0.namespace,
    "/",
    kubernetes_service_account.workload.metadata.0.name,
    "]"
  ])
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.workload.name
}

output "google_service_account" {
  value = google_service_account.workload
}
