#resource "random_integer" "host_project_suffix" {
#  min = 1
#  max = 999999
#}
#
#resource "google_project" "host_project" {
#  name                = "personal-${terraform.workspace}-host"
#  project_id          = "personal-${terraform.workspace}-host-${random_integer.host_project_suffix.result}"
#  folder_id           = google_folder.personal.id
#  billing_account     = data.google_billing_account.my_billing_account.id
#  auto_create_network = false
#}
#
#resource "google_project_service" "host_project_apis" {
#  for_each = toset([
#    "cloudkms.googleapis.com",
#    "cloudresourcemanager.googleapis.com",
#    "iam.googleapis.com",
#    "iamcredentials.googleapis.com",
#    "storage.googleapis.com",
#    "sts.googleapis.com"
#  ])
#
#  project                    = google_project.host_project.id
#  service                    = each.key
#  disable_dependent_services = true
#  disable_on_destroy         = true
#}
