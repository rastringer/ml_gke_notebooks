# Resource to generate a random suffix for the bucket name
# This helps ensure the bucket name is unique across all of Google Cloud Storage
resource "random_string" "bucket_suffix" {
  length  = 8   # Generate a suffix of 8 lowercase letters
  special = false  # Exclude special characters for simplicity
  upper   = false  
  lower   = true
}

# Resource to create the Google Cloud Storage bucket for ML data
resource "google_storage_bucket" "ml_bucket" {
  name          = "gke-ml-${random_string.bucket_suffix.result}"  

  location      = var.region    # Set the bucket location based on your variable input
  force_destroy = true  
  # Enable force_destroy to allow Terraform to delete the bucket 
  # even if it contains objects

  uniform_bucket_level_access = true  
  # Use uniform bucket-level access for simplified IAM permissions
}
