#resource "google_container_node_pool" "gke_node_pool" {
#  cluster        = google_container_cluster.gke_cluster.name
#  location       = var.gke_location
#  name           = terraform.workspace
#  node_count     = 1
#  node_locations = var.gke_node_locations
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
#    machine_type    = var.gke_node_pool_machine_type
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
#
#resource "google_service_account" "gke_node_pool" {
#  account_id   = "${terraform.workspace}-node-pool"
#  description  = "The default service account for pods to use in ${terraform.workspace}"
#  display_name = "GKE Node Pool ${terraform.workspace} Service Account"
#}
#
#resource "google_project_iam_member" "gke_node_pool" {
#  member = "serviceAccount:${google_service_account.gke_node_pool.email}"
#  role   = "roles/viewer"
#}
#
#variable "gke_node_locations" {
#  description = "The list of zones in which the node pool's nodes should be located"
#  sensitive   = true
#  type        = list(string)
#}
#
#variable "gke_node_pool_machine_type" {
#  default     = "g1-small"
#  description = "Machine size for GKE node pool"
#  sensitive   = true
#  type        = string
#}
