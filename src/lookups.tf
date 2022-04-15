data "google_projects" "automation_lookup" {
  filter = "name:automation lifecycleState:ACTIVE"
}

data "google_project" "automation" {
  project_id = data.google_projects.automation_lookup.projects[0].project_id
}

data "google_service_account" "automation" {
  account_id = "automation@${data.google_project.automation.project_id}.iam.gserviceaccount.com"
}

data "google_billing_account" "my_billing_account" {
  display_name = "My Billing Account"
  open         = true
}

data "google_organization" "harmelodic_com" {
  domain = "harmelodic.com"
}

data "google_folders" "organisation_folders" {
  parent_id = data.google_organization.harmelodic_com.id
}
