// Lookups
data "google_projects" "automation_lookup" {
  filter = "name:automation lifecycleState:ACTIVE"
}

data "google_project" "automation" {
  project_id = data.google_projects.automation_lookup.projects[0].project_id
}

data "google_service_account" "automation" {
  account_id = "automation@${data.google_project.automation.project_id}.iam.gserviceaccount.com"
}

// Giving Automation Service Account Permissions

// ...