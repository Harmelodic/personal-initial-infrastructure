# General Variables
region                          = "europe-north1"

# Apps Variables
apps_db_disk_size               = 10
apps_db_tier                    = "db-n1-standard-1"
apps_gke_location               = "europe-north1-b"
apps_gke_node_count             = 3
apps_gke_node_pool_machine_type = "g1-small"

apps_gke_node_locations = [
  "europe-north1-b"
]

# Domain Variables
apps_harmelodic_dns_name = "harmelodic.com"
