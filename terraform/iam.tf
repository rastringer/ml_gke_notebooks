# Service Account creation
resource "google_service_account" "gke_node_sa" {
  account_id   = "gke-node-sa"
  display_name = "Service Account for GKE Nodes"
}

resource "google_service_account" "pod_service_account" {
  account_id   = "ml-pod-sa"
  display_name = "Service Account for Pod Access"
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

# Wait for Workload Identity to be enabled
resource "time_sleep" "wait_for_workload_identity" {
  depends_on      = [google_container_cluster.gke_ml_cluster]
  create_duration = "60s"  # Adjust wait time if needed
}

resource "google_service_account_iam_member" "workload_identity_binding" {
  service_account_id = google_service_account.pod_service_account.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[default/ml-pod-access]"
  depends_on         = [time_sleep.wait_for_workload_identity]
}

resource "google_storage_bucket_iam_binding" "bucket_viewer" {
  bucket = google_storage_bucket.ml_bucket.name
  role   = "roles/storage.objectViewer"
  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[default/ml-pod-access]" 
  ]
  depends_on = [time_sleep.wait_for_workload_identity]
}
