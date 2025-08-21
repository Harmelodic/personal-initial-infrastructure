resource "random_integer" "artifacts_project_suffix" {
  min = 1
  max = 999999
}

resource "google_project" "artifacts" {
  auto_create_network = false
  billing_account     = data.google_billing_account.my_billing_account.id
  folder_id           = google_folder.personal.id
  name                = "personal-artifacts"
  project_id          = "personal-artifacts-${random_integer.artifacts_project_suffix.result}"
}

resource "google_project_iam_audit_config" "artifacts" {
  project = google_project.artifacts.id
  service = "allServices"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }
}

resource "google_project_service" "artifacts_apis" {
  for_each = toset([
    "artifactregistry.googleapis.com", # Required for storing Artifacts
  ])

  disable_dependent_services = true
  disable_on_destroy         = true
  project                    = google_project.artifacts.project_id
  service                    = each.key
}

resource "google_project_iam_member" "personal_artifacts_project_automation_perms" {
  # checkov:skip=CKV_GCP_49: TODO Review using project permissions
  # checkov:skip=CKV_GCP_117: TODO: Review using owner
  for_each = toset([
    "roles/billing.projectManager",
    "roles/owner",
  ])

  member  = "serviceAccount:${data.google_service_account.automation.email}"
  project = google_project.artifacts.project_id
  role    = each.key
}
