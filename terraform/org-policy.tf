resource "google_project_organization_policy" "shielded_vm" {
  project    = var.project_id              // The Google Cloud project to apply the policy to
  constraint = "compute.requireShieldedVm" // Policy restriction name

  restore_policy {
    default = true // Resets to the default behavior if this policy is deleted
  }
}

resource "google_project_organization_policy" "vm_external_ip_access" {
  project    = var.project_id               // The Google Cloud project to apply the policy to
  constraint = "compute.vmExternalIpAccess" // Policy restriction name

  restore_policy {
    default = true // Resets to the default behavior if this policy is deleted
  }
}
