variable "apps_gke_location" {
  description = "Location of where GKE cluster will be created"
  sensitive   = true
  type        = string
}

resource "google_container_cluster" "apps" {
  description                 = "GKE Cluster for personal projects"
  enable_binary_authorization = false
  enable_intranode_visibility = false
  enable_legacy_abac          = false
  enable_shielded_nodes       = true
  enable_tpu                  = false
  initial_node_count          = 1
  location                    = var.apps_gke_location
  logging_service             = "logging.googleapis.com/kubernetes"
  min_master_version          = "1.21"
  name                        = "apps"
  network                     = google_compute_network.main.id
  project                     = google_project.apps.project_id
  remove_default_node_pool    = true
  subnetwork                  = google_compute_subnetwork.apps.id

  resource_labels = {
    environment = terraform.workspace
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }

    http_load_balancing {
      disabled = false
    }

    network_policy_config {
      disabled = true
    }
  }

  cluster_autoscaling {
    enabled = false
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = local.cluster_secondary_range_name
    services_secondary_range_name = local.services_secondary_range_name
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "00:00"
    }
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = false
  }

  network_policy {
    enabled = false
  }

  release_channel {
    channel = "RAPID"
  }

  workload_identity_config {
    workload_pool = "${google_project.apps.project_id}.svc.id.goog"
  }
}
