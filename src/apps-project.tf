resource "random_integer" "apps_project_suffix" {
  min = 1
  max = 999999
}

resource "google_project" "apps" {
  auto_create_network = false
  billing_account     = data.google_billing_account.my_billing_account.id
  folder_id           = google_folder.personal.id
  name                = "personal-${terraform.workspace}-apps"
  project_id          = "personal-${terraform.workspace}-apps-${random_integer.apps_project_suffix.result}"
}

resource "google_project_service" "apis" {
  for_each = toset([
    "cloudbilling.googleapis.com", # Required for hooking project to Cloud Billing
    "iam.googleapis.com", # Required for handling IAM permissions
  ])

  disable_dependent_services = true
  disable_on_destroy         = true
  project                    = google_project.apps.project_id
  service                    = each.key
}
