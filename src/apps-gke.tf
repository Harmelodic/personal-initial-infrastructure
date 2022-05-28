variable "apps_gke_location" {
  description = "Location of where GKE cluster will be created"
  sensitive   = true
  type        = string
}

# Grant GKE Service Agent access to host project GKE
resource "google_project_iam_member" "gke_service_agent_host_perms" {
  for_each = toset([
    "roles/container.hostServiceAgentUser",
    "roles/compute.networkUser"
  ])

  member  = "serviceAccount:service-${google_project.apps.number}@container-engine-robot.iam.gserviceaccount.com"
  project = google_project.host.project_id
  role    = each.key
}

resource "google_container_cluster" "apps" {
  depends_on = [
    google_project_service.host_apis,
    google_project_service.apps_apis,
    google_project_iam_member.gke_service_agent_perms,
    google_project_iam_member.gke_service_agent_host_perms,
    google_compute_route.main_default_internet_gateway
  ]

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
