#variable "apps_db_tier" {
#  default     = "db-n1-standard-1"
#  description = "Type of DB machine"
#  sensitive   = true
#  type        = string
#}
#
#variable "apps_db_disk_size" {
#  default     = 10
#  description = "Size of DB storage in GB"
#  sensitive   = true
#  type        = number
#}
#
#resource "google_sql_database_instance" "instance" {
#  name                = "apps"
#  region              = var.region
#  database_version    = "MYSQL_8_0"
#  deletion_protection = false
#  project             = google_project.apps.project_id
#
#  settings {
#    tier      = var.apps_db_tier
#    disk_size = var.apps_db_disk_size
#    disk_type = "PD_SSD"
#
#    backup_configuration {
#      enabled  = true
#      location = var.region
#
#      backup_retention_settings {
#        retained_backups = 2
#        retention_unit   = "COUNT"
#      }
#    }
#
#    ip_configuration {
#      ipv4_enabled = true
#      require_ssl  = true
#    }
#
#    maintenance_window {
#      day          = 2
#      hour         = 3
#      update_track = "stable"
#    }
#  }
#}
#