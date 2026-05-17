provider "google" {
  project = var.project_id
  region  = "us-central1"
}

resource "google_secret_manager_secret" "tenant_secret" {
  secret_id = "tenant-${var.tenant_name}-credentials"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "tenant_secret_version" {
  secret = google_secret_manager_secret.tenant_secret.id

  secret_data = jsonencode({
    username = replace(var.tenant_name, "-", "_")
    password = var.db_password
  })
}

resource "google_service_account" "tenant_gsa" {
  account_id   = "${var.tenant_name}-gsa"
  display_name = "Tenant GSA"
}

resource "google_secret_manager_secret_iam_member" "tenant_secret_access" {
  secret_id = google_secret_manager_secret.tenant_secret.id
  role      = "roles/secretmanager.secretAccessor"

  member = "serviceAccount:${google_service_account.tenant_gsa.email}"
}

what is terraform plan ouput 