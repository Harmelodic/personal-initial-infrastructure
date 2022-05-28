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

resource "google_project_service" "apps_apis" {
  for_each = toset([
    "cloudbilling.googleapis.com", # Required for hooking project to Cloud Billing
    "container.googleapis.com", # Required for using Google Kubernetes Engine
    "iam.googleapis.com", # Required for handling IAM permissions
  ])

  disable_dependent_services = true
  disable_on_destroy         = true
  project                    = google_project.apps.project_id
  service                    = each.key
}

resource "google_compute_shared_vpc_service_project" "apps" {
  host_project    = google_project.host.project_id
  service_project = google_project.apps.project_id
}

resource "google_project_iam_member" "automation_apps_project_perms" {
  for_each = toset([
    "roles/billing.projectManager",
    "roles/editor",
  ])

  member  = "serviceAccount:${data.google_service_account.automation.email}"
  project = google_project.apps.project_id
  role    = each.key
}

# Explicit Kubernetes Engine Service Agent - normally granted when enabling Kubernetes API
resource "google_project_iam_member" "gke_service_agent_perms" {
  for_each = toset([
    "roles/container.serviceAgent",
  ])

  member  = "serviceAccount:service-${google_project.apps.number}@container-engine-robot.iam.gserviceaccount.com"
  project = google_project.apps.project_id
  role    = each.key
}
