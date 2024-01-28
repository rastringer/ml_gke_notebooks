resource "google_compute_network" "gke_ml" {
  project                 = var.project_id                // Specifies the GCP project for this network
  name                    = var.vpc                       // Dynamically names the VPC (e.g., vpc-abcd1234)
  auto_create_subnetworks = false                         // Disables automatic subnet creation 
  depends_on              = [time_sleep.apis_propagation] // Ensures APIs are enabled before network creation
}

resource "google_compute_subnetwork" "gke_ml" {
  project       = var.project_id                     // Specifies the project
  name          = "gke-primary"                      // Name of the subnet
  ip_cidr_range = var.gke_node_subnet                //  IP address range for GKE worker nodes
  region        = var.region                         // Region for the subnet
  network       = google_compute_network.gke_ml.name // Links the subnet to the 'gke_ml' network
  depends_on    = [time_sleep.apis_propagation]      // Ensures APIs are enabled 

  secondary_ip_range {
    range_name    = "gke-pods"         // Name for the pod IP range
    ip_cidr_range = var.gke_pod_subnet // IP address range for Kubernetes pods
  }
  secondary_ip_range {
    range_name    = "gke-services"          // Name for the service IP range
    ip_cidr_range = var.gke_services_subnet // IP address range for Kubernetes services
  }
}
