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

resource "google_service_account_iam_member" "cert_manager_workload_identity" {
  member             = "serviceAccount:${google_project.apps.project_id}.svc.id.goog[cert-manager/cert-manager]"
  project            = google_project.apps.project_id
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.cert_manager.name
}
