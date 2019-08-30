resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "master" {
  name = "master-instance-${random_id.db_name_suffix.hex}"
  region = "us-central"
  settings {
    tier = "D0"
  }
}

# resource "google_sql_database" "users" {
#   name      = "users-db"
#   instance  = "${google_sql_database_instance.master.name}"
#   charset   = "UTF8"
#   collation = "en_US.UTF8"
# }