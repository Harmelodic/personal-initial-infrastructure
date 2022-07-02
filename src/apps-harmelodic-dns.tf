variable "apps_harmelodic_dns_name" {
  description = "Harmelodic domain name used for this environment"
  sensitive   = true
  type        = string
}

resource "google_dns_managed_zone" "harmelodic_com" {
  depends_on = [
    google_project_service.host_apis
  ]

  description = "Managed Zone for ${var.apps_harmelodic_dns_name}"
  dns_name    = "${var.apps_harmelodic_dns_name}."
  name        = replace(var.apps_harmelodic_dns_name, ".", "-")
  project     = google_project.host.project_id

  dnssec_config {
    state = "on"
  }

  labels = {
    environment = terraform.workspace
  }
}

resource "google_dns_record_set" "harmelodic_com_a" {
  managed_zone = google_dns_managed_zone.harmelodic_com.name
  name         = "${var.apps_harmelodic_dns_name}."
  project      = google_project.host.project_id
  ttl          = 300
  type         = "A"

  rrdatas = [
    "34.88.47.19",
  ]
}

resource "google_dns_record_set" "harmelodic_com_cname" {
  managed_zone = google_dns_managed_zone.harmelodic_com.name
  name         = "*.${var.apps_harmelodic_dns_name}."
  project      = google_project.host.project_id
  ttl          = 300
  type         = "CNAME"

  rrdatas = [
    "${var.apps_harmelodic_dns_name}."
  ]
}

resource "google_dns_record_set" "harmelodic_com_mx" {
  managed_zone = google_dns_managed_zone.harmelodic_com.name
  name         = "${var.apps_harmelodic_dns_name}."
  project      = google_project.host.project_id
  ttl          = 3600
  type         = "MX"

  rrdatas = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
    "10 alt4.aspmx.l.google.com."
  ]
}

resource "google_dns_record_set" "harmelodic_com_txt" {
  managed_zone = google_dns_managed_zone.harmelodic_com.name
  name         = "${var.apps_harmelodic_dns_name}."
  project      = google_project.host.project_id
  ttl          = 300
  type         = "TXT"

  rrdatas = [
    "google-site-verification=jXVba9WLVzprbkW4EpS3vtWL5-2YH03AwSc8sprMfSU",
    "keybase-site-verification=sDm605nNkmQuRsuciUxr9KmDkMgBVUKD5Ea38C_8L4w",
    "extra-custom-value=hello-matt"
  ]
}
