terraform {
  required_version = ">=1.1.8"

  backend "gcs" {
    bucket = "harmelodic-tfstate"
    prefix = "personal-infrastructure"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.11.0"
    }
  }
}

provider "google" {
  region = var.region
}

variable "region" {
  default     = "europe-north1"
  description = "GCP Region"
  sensitive   = true
  type        = string
}
