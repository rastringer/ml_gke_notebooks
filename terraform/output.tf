output "get_credentials_command" {
  value       = "gcloud container clusters get-credentials ${google_container_cluster.gke_ml_cluster.name} --zone ${google_container_cluster.gke_ml_cluster.location} --project ${var.project_id}"
  description = "Run this command to configure kubectl access to your GKE cluster"
}
