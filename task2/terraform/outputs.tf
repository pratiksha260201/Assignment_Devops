output "secret_name" {
  value = google_secret_manager_secret.tenant_secret.secret_id
}

output "gsa_email" {
  value = google_service_account.tenant_gsa.email
}