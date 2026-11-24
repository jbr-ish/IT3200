terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-west1"
}

variable "project_id" {
  description = "Your Google Cloud project ID"
  type        = string
}

resource "google_storage_bucket" "student" {
  name                        = "uvu-jacob-rowe-bucket"
  location                    = "US-WEST1"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

output "bucket_name" {
  value = google_storage_bucket.student.name
}