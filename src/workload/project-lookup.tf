variable "project_id" {
  description = "Project ID of the Project the Workload will be deployed to"
  type = string
}

data "google_project" "target" {
  project_id = var.project_id
}
