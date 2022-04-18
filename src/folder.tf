resource "google_folder" "personal" {
  display_name = "Personal - ${title(terraform.workspace)}"
  parent       = data.google_organization.harmelodic_com.id
}
