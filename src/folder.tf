resource "google_folder" "personal" {
  display_name = "Personal"
  parent       = data.google_organization.harmelodic_com.id
}

resource "google_folder" "personal_env" {
  display_name = terraform.workspace
  parent       = google_folder.personal.id
}

resource "google_folder_iam_member" "automation_folder_perms" {
  for_each = toset([
    "roles/compute.xpnAdmin",
  ])

  member = "serviceAccount:${data.google_service_account.automation.email}"
  folder = google_folder.personal.id
  role   = each.key
}
