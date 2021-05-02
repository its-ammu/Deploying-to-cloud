provider "google" {
  credentials = file("sa-acnt-key.json")
  project     = var.gcp_project_id
  region      = "us-central1"
  zone        = "us-central1-a"
}

data "google_compute_network" "default" {
  name = "default"
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["allow-http"]
}

data "google_compute_image" "cos_image" {
  family  = "cos-81-lts"
  project = "cos-cloud"
}

resource "google_compute_instance" "instance" {
  name         = "${var.app_name}-vm"
  machine_type = var.gcp_machine_type
  zone         = "us-central1-a"

  tags = google_compute_firewall.allow_http.target_tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.cos_image.self_link
    }
  }

  network_interface {
    network = data.google_compute_network.default.name

    access_config {
      
    }
  }

  service_account {
    scopes = ["storage-ro"]
  }
}