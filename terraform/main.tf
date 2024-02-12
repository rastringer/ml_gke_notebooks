# resource "random_string" "id" {
#   length  = 3
#   upper   = false
#   special = false
# }

# locals {
#   # used throughout to generate a unique name for the deployment
#   # means this can easily be re-used for multiple workspaces for example
#   uid = "${var.name}-${random_string.id.result}"
# }

##### Setup Project #####

# Used to pull the provider projects billing/org IDs for our fresh project
# data "google_project" "tf-project" {
# }

# resource "google_compute_project_metadata_item" "default" {
#   project = var.project_id
#   key     = "enable-osconfig"
#   value   = "TRUE"
# }
