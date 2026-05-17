provider "google" {
  project = "demo-project"
  region  = "asia-east1"
}

resource "google_sql_database" "tenant_db" {
  name     = replace(var.tenant_name, "-", "_")
  instance = var.db_instance_name
}

resource "google_sql_user" "tenant_user" {
  name     = replace(var.tenant_name, "-", "_")
  instance = var.db_instance_name
  password = var.db_password
} 