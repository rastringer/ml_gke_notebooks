# Service Account creation
resource "google_service_account" "gke_node_sa" {
  account_id   = "gke-node-sa"
  display_name = "Service Account for GKE Nodes"
}

# Grant IAM roles to the service account
resource "google_project_iam_member" "node_sa_roles" {
  project = var.project_id

  # List of roles to be assigned 
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/autoscaling.metricsWriter",
    "roles/artifactregistry.reader"
  ])

  role   = each.key
  member = "serviceAccount:${google_service_account.gke_node_sa.email}"
}
