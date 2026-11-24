terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-west1"
}

variable "project_id" {
  description = "The GCP Project ID where the VM will be created"
  type        = string
}

# Dynamically fetch all available zones in us-west1 (e.g., us-west1-a, us-west1-b, us-west1-c)
data "google_compute_zones" "available" {
  region = "us-west1"
  status = "UP"
}

# Randomly select one active zone from us-west1
resource "random_shuffle" "zone" {
  input        = data.google_compute_zones.available.names
  result_count = 1
}

resource "google_compute_instance" "default" {
  name         = "windows-uvu-it3200-jacob"
  machine_type = "e2-medium"
  zone         = random_shuffle.zone.result[0]

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2025"
      size  = 50
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Leave empty to assign an ephemeral public IP address
    }
  }
}

output "vm_zone" {
  description = "The zone in us-west1 where the VM was placed"
  value       = google_compute_instance.default.zone
}