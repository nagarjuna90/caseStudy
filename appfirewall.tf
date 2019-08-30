

# resource "google_app_engine_application" "app" {
#   project     = "aerial-passage-248314"
#   location_id = "us-east1"
# }

# resource "google_app_engine_firewall_rule" "rule" {
#   project = "${google_app_engine_application.app.project}"
#   priority = 1000
#   action = "ALLOW"
#   source_range = "*"
# }