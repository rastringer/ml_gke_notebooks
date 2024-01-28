# Enable the required Google Cloud API's for the Drone Derby Infrastructure
resource "google_project_service" "apis" {
  for_each = toset([
    "monitoring.googleapis.com",           # Enable monitoring services
    "logging.googleapis.com",              # Enable logging
    "cloudtrace.googleapis.com",           # Enable distributed tracing
    "cloudresourcemanager.googleapis.com", # For managing GCP resources
    "stackdriver.googleapis.com",          # Additional monitoring features (legacy, often enabled by default)
    "iam.googleapis.com",                  # Manage IAM (Identity and Access Management)
    "compute.googleapis.com",              # For creating VMs and other compute resources
    "container.googleapis.com"             # For GKE (Google Kubernetes Engine)
  ])
  project                    = var.project_id # Target project 
  service                    = each.value     # Iterate through the API list
  disable_on_destroy         = false          # Keep APIs enabled even if Terraform destroys resources
  disable_dependent_services = false          # Prevents cascading disabling of dependent services
}

# Wait a little while for the API's to enable consistently
resource "time_sleep" "apis_propagation" {
  depends_on = [
    google_project_service.apis, # Ensure the APIs are enabled before proceeding
  ]
  create_duration = "240s" # A delay of 4 minutes to allow API changes to propagate
}
