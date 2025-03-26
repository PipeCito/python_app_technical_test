resource "google_compute_network" "test" {
  name                    = "test"
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_subnetwork" "test-us-east4-subnetwork" {
  name                     = "test-useast4"
  project                  = var.project_id
  ip_cidr_range            = "10.2.0.0/16"
  region                   = "us-east4"
  network                  = google_compute_network.test.self_link
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_1_MIN"
    flow_sampling        = "0.001"
  }
  secondary_ip_range {
    range_name    = "us-east4-test"
    ip_cidr_range = "10.18.0.0/19"
  }
  secondary_ip_range {
    range_name    = "us-east4-test-svcs"
    ip_cidr_range = "10.18.32.0/19"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_firewall" "allow-http" {
  name    = "allow-http"
  direction = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  network = google_compute_network.test.id
  allow {
    protocol = "tcp"
    ports    = ["80","443"]
  }
}