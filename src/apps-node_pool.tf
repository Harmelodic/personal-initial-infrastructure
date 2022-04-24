variable "apps_gke_node_count" {
  description = "The number of nodes on the Apps cluster"
  sensitive   = true
  type        = number
}

variable "apps_gke_node_locations" {
  description = "The list of zones in which the node pool's nodes should be located"
  sensitive   = true
  type        = list(string)
}

variable "apps_gke_node_pool_machine_type" {
  description = "Machine size for GKE node pool"
  sensitive   = true
  type        = string
}

#resource "google_service_account" "gke_node_pool" {
#  account_id   = "apps-node-pool"
#  description  = "The default service account for pods to use in the apps node pool"
#  display_name = "Apps GKE Node Pool Service Account"
#  project      = google_project.apps.project_id
#}
#
#resource "google_project_iam_member" "gke_node_pool_perms" {
#  for_each = toset([
#    "roles/viewer",
#  ])
#
#  member  = "serviceAccount:${google_service_account.gke_node_pool.email}"
#  project = google_project.apps.project_id
#  role    = each.key
#}
#
#resource "google_container_node_pool" "apps" {
#  cluster        = google_container_cluster.apps.name
#  location       = var.apps_gke_location
#  name           = "apps"
#  node_count     = var.apps_gke_node_count
#  node_locations = var.apps_gke_node_locations
#  project        = google_project.apps.project_id
#
#  management {
#    auto_repair  = true
#    auto_upgrade = true
#  }
#
#  node_config {
#    disk_size_gb    = 100
#    disk_type       = "pd-standard"
#    image_type      = "cos_containerd"
#    local_ssd_count = 0
#    machine_type    = var.apps_gke_node_pool_machine_type
#    preemptible     = false
#    service_account = google_service_account.gke_node_pool.email
#
#    labels = {
#      environment = terraform.workspace
#    }
#
#    metadata = {
#      disable-legacy-endpoints = true
#    }
#
#    tags = [
#      terraform.workspace
#    ]
#
#    shielded_instance_config {
#      enable_integrity_monitoring = true
#      enable_secure_boot          = true
#    }
#  }
#
#  upgrade_settings {
#    max_surge       = 2
#    max_unavailable = 1
#  }
#}
