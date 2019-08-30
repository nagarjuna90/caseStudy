resource "google_compute_network" "default" {
  name = "test-network2"
  project = "aerial-passage-248314"
}

resource "google_compute_firewall" "default" {
  name    = "test2-firewall"
  network = "${google_compute_network.default.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
}
