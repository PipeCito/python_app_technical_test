terraform {
  required_version = "1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.20.0"
    }
  }
  backend "gcs" {
    bucket = "elaborate-baton-340602-terraform"
    prefix = "technical-test-devops/network"
  }
}

provider "google" {
  project = var.project_id
}