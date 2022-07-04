resource "google_folder" "personal" {
  display_name = "Personal"
  parent       = data.google_organization.harmelodic_com.id
}
