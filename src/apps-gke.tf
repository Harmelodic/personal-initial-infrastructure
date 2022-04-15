#resource "google_container_cluster" "gke_cluster" {
#  description                 = "GKE Cluster for personal projects"
#  enable_binary_authorization = false
#  enable_intranode_visibility = false
#  enable_legacy_abac          = false
#  enable_shielded_nodes       = true
#  enable_tpu                  = false
#  initial_node_count          = 1
#  location                    = var.gke_location
#  logging_service             = "logging.googleapis.com/kubernetes"
#  name                        = terraform.workspace
#  network                     = google_compute_network.gke.self_link
#  remove_default_node_pool    = true
#  subnetwork                  = google_compute_subnetwork.gke.self_link
#
#  resource_labels = {
#    environment = terraform.workspace
#  }
#
#  addons_config {
#    horizontal_pod_autoscaling {
#      disabled = false
#    }
#
#    http_load_balancing {
#      disabled = false
#    }
#
#    network_policy_config {
#      disabled = true
#    }
#  }
#
#  cluster_autoscaling {
#    enabled = false
#  }
#
#  ip_allocation_policy {
#    cluster_secondary_range_name  = local.cluster_secondary_range_name
#    services_secondary_range_name = local.services_secondary_range_name
#  }
#
#  maintenance_policy {
#    daily_maintenance_window {
#      start_time = "00:00"
#    }
#  }
#
#  private_cluster_config {
#    enable_private_endpoint = false
#  }
#
#  network_policy {
#    enabled = false
#  }
#
#  release_channel {
#    channel = "RAPID"
#  }
#
#  workload_identity_config {
#    identity_namespace = "${var.project_id}.svc.id.goog"
#  }
#}
#
#resource "google_compute_network" "gke" {
#  auto_create_subnetworks         = false
#  delete_default_routes_on_create = false
#  description                     = "Compute Network for GKE nodes"
#  name                            = "${terraform.workspace}-gke"
#  routing_mode                    = "GLOBAL"
#}
#
#resource "google_compute_subnetwork" "gke" {
#  name          = "${terraform.workspace}-gke-subnetwork"
#  ip_cidr_range = "10.255.0.0/16"
#  region        = var.region
#  network       = google_compute_network.gke.id
#
#  secondary_ip_range {
#    range_name    = local.cluster_secondary_range_name
#    ip_cidr_range = "10.0.0.0/12"
#  }
#
#  secondary_ip_range {
#    range_name    = local.services_secondary_range_name
#    ip_cidr_range = "10.16.0.0/12"
#  }
#}
#
#locals {
#  cluster_secondary_range_name = "cluster-secondary-range"
#  services_secondary_range_name = "services-secondary-range"
#}
#
#variable "gke_location" {
#  default     = "europe-north1"
#  description = "Location of where GKE cluster will be created"
#  sensitive   = true
#  type        = string
#}
