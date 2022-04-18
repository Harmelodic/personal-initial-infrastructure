resource "random_integer" "host_project_suffix" {
  min = 1
  max = 999999
}

resource "google_project" "host" {
  name                = "personal-${terraform.workspace}-host"
  project_id          = "personal-${terraform.workspace}-host-${random_integer.host_project_suffix.result}"
  folder_id           = google_folder.personal.id
  billing_account     = data.google_billing_account.my_billing_account.id
  auto_create_network = false
}

resource "google_project_service" "host_apis" {
  for_each = toset([
    "cloudbilling.googleapis.com", # Required for hooking project to Cloud Billing
    "iam.googleapis.com", # Required for handling IAM permissions
  ])

  project                    = google_project.host.id
  service                    = each.key
  disable_dependent_services = true
  disable_on_destroy         = true
}

resource "google_compute_shared_vpc_host_project" "host" {
  project = google_project.host.project_id
}
