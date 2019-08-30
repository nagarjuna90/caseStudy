provider "google" {
  credentials = "${file("account.json")}"
  project     = "aerial-passage-248314"
  region      = "us-central1"
}



resource "google_storage_bucket" "image-store" {
  name     = "store-bucket"
  location = "US"
  project = "aerial-passage-248314"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}