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
  name         = "ubuntu-uvu-it3200-jacob"
  machine_type = "e2-micro"
  zone         = random_shuffle.zone.result[0]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2610-amd64"
      size  = 10
      type  = "pd-standard"
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

output "vm_external_ip" {
  description = "The public IP address of the newly created VM"
  value       = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}