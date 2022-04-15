#resource "google_folder" "personal" {
#  display_name = "Personal - ${title(terraform.workspace)}"
#  parent       = data.google_organization.harmelodic_com.id
#}
#
#resource "google_folder_iam_member" "operations-automation" {
#  folder  = google_folder.personal.id
#  member  = "serviceAccount:${data.google_service_account.automation.email}"
#  role    = "roles/owner"
#}
