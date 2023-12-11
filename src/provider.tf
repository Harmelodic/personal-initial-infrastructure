terraform {
  required_version = ">=1.1.8"

  backend "gcs" {
    bucket = "harmelodic-tfstate"
    prefix = "personal-base-infrastructure"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.9.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}

variable "region" {
  default     = "europe-north1"
  description = "GCP Region"
  sensitive   = true
  type        = string
}

provider "google" {
  region = var.region
}
