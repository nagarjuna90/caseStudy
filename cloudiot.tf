resource "google_pubsub_topic" "default-devicestatus" {
  name = "default-devicestatus"
  project = "aerial-passage-248314"
}

resource "google_pubsub_topic" "default-telemetry" {
  name = "default-telemetry"
  project = "aerial-passage-248314"
}

resource "google_cloudiot_registry" "default-registry" {
  name = "default-registry"
  project = "aerial-passage-248314"
  event_notification_config = {
    pubsub_topic_name = "${google_pubsub_topic.default-telemetry.id}"
  }

  state_notification_config = {
    pubsub_topic_name = "${google_pubsub_topic.default-devicestatus.id}"
  }

  http_config = {
    http_enabled_state = "HTTP_ENABLED"
  }

  mqtt_config = {
    mqtt_enabled_state = "MQTT_ENABLED"
  }

  # credentials = [
  #   {
  #     public_key_certificate = {
  #       format      = "X509_CERTIFICATE_PEM"
  #       certificate = "${file("rsa_cert.pem")}"
  #     }
  #   },
  # ]
}
