#resource "random_integer" "apps_project_suffix" {
#  min = 1
#  max = 999999
#}
#
#resource "google_project" "apps_project" {
#  name                = "personal-${terraform.workspace}-apps"
#  project_id          = "personal-${terraform.workspace}-apps-${random_integer.apps_project_suffix.result}"
#  folder_id           = google_folder.personal.id
#  billing_account     = data.google_billing_account.my_billing_account.id
#  auto_create_network = false
#}
#
#resource "google_project_service" "apis" {
#  for_each = toset([
#    "artifactregistry.googleapis.com",
#    "cloudapis.googleapis.com",
#    "cloudresourcemanager.googleapis.com",
#    "compute.googleapis.com",
#    "container.googleapis.com",
#    "containerregistry.googleapis.com",
#    "iam.googleapis.com",
#    "iamcredentials.googleapis.com",
#    "logging.googleapis.com",
#    "monitoring.googleapis.com",
#    "sql-component.googleapis.com",
#    "sqladmin.googleapis.com",
#    "stackdriver.googleapis.com",
#    "storage-component.googleapis.com",
#    "storage.googleapis.com"
#  ])
#
#  disable_dependent_services = true
#  disable_on_destroy         = true
#  service                    = each.key
#}
