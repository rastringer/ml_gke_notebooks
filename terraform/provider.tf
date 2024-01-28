provider "google" {
  project         = var.project_id
  region          = var.region
  zone            = var.zone
  request_timeout = "60s"
}

provider "google-beta" {
  alias           = "robot-account"
  project         = var.project_id
  region          = var.region
  zone            = var.zone
  request_timeout = "60s"
}
