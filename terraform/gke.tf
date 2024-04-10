# Obtain default client credentials for authentication
data "google_client_config" "default" {}

# Configure the Kubernetes provider
provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"               # Connects to the GKE endpoint
  token                  = data.google_client_config.default.access_token # Authentication token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)        # Trust the GKE cluster's certificate
}

# GKE Cluster
resource "google_container_cluster" "gke_ml_cluster" {
  name                     = var.cluster_name
  location                 = var.zone                              # Deployment zone
  network                  = google_compute_network.gke_ml.name    # VPC network
  subnetwork               = google_compute_subnetwork.gke_ml.name # Subnetwork
  remove_default_node_pool = true                                  # Prevent the default node pool from being created
  deletion_protection      = false                                 # Allow deletion of the cluster (adjust as needed)

  # Initial node pool (important for later creation of GPU nodes)
  initial_node_count = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.gke_ml.secondary_ip_range.0.range_name # Pod IP range
    services_secondary_range_name = google_compute_subnetwork.gke_ml.secondary_ip_range.1.range_name # Service IP range
  }

  monitoring_config {
    managed_prometheus {
      enabled = true # Enable Google Managed Prometheus for monitoring
    }
  }

  depends_on = [time_sleep.apis_propagation]
}

# GPU Node Pool
resource "google_container_node_pool" "gpu_nodes" {
  name       = "gpu-pool"
  location   = var.zone                                     # Deployment zone
  cluster    = google_container_cluster.gke_ml_cluster.name # Attach to the main cluster
  node_count = 1                                            # Number of nodes in the pool

  node_config {
    machine_type = "n1-standard-4" # Machine type with GPUs (adjust as needed)

    # GPU Configuration
    guest_accelerator {
      count = 1
      type  = var.accelerator_type # Type of GPU
      # Allows multiple containers to share the same GPU
      gpu_sharing_config {
        gpu_sharing_strategy = "TIME_SHARING"
        max_shared_clients_per_gpu = 4
      }
    }

    # Important for GPU workload support
    service_account = google_service_account.gke_node_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  depends_on = [time_sleep.apis_propagation]
}
