 resource "google_compute_network" "vpc_network" {
   project = "aerial-passage-248314"
   name = "vpc-network-test"
   ipv4_range = "192.168.0.0/24"
   auto_create_subnetworks = "false"
 }

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.name}"
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.0.0/25"
  }
}


