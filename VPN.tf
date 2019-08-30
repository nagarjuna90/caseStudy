//need a lot of specifying to do

resource "google_compute_vpn_tunnel" "tunnel1" {
  name          = "tunnel1"
  project = "aerial-passage-248314"
  peer_ip       = "15.0.0.120"
  shared_secret = "a secret message"

  target_vpn_gateway = "${google_compute_vpn_gateway.target_gateway.name}"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp",
    "google_compute_forwarding_rule.fr_udp500",
    "google_compute_forwarding_rule.fr_udp4500",
  ]
}

resource "google_compute_vpn_gateway" "target_gateway" {
  name    = "vpn1"
  project = "aerial-passage-248314"
  network = "${google_compute_network.vpc_network.name}"
}

# resource "google_compute_network" "network1" {
#   name       = "network1"
# }

resource "google_compute_address" "vpn_static_ip" {
  name   = "vpn-static-ip"
  project = "aerial-passage-248314"
  address = "192.168.0.0" //need to make an address
}

resource "google_compute_forwarding_rule" "fr_esp" {
  name        = "fr-esp"
  ip_protocol = "ESP"
  ip_address  = "${google_compute_address.vpn_static_ip.address}"
  target      = "${google_compute_vpn_gateway.target_gateway.self_link}"
}

resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${google_compute_address.vpn_static_ip.address}"
  target      = "${google_compute_vpn_gateway.target_gateway.name}"
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${google_compute_address.vpn_static_ip.address}"
  target      = "${google_compute_vpn_gateway.target_gateway.name}"
}

resource "google_compute_route" "route1" {
  name       = "route1"
  project = "aerial-passage-248314"
  network    = "${google_compute_network.vpc_network.name}"
  dest_range = "15.0.0.0/24"
  priority   = 1000

  next_hop_vpn_tunnel = "${google_compute_vpn_tunnel.tunnel1.name}"
}