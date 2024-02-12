variable "accelerator_type" {
  description = "Accelerator type"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "gke_node_subnet" {
  description = "Subnet CIDR"
  type        = string
}

variable "gke_pod_subnet" {
  description = "Subnet CIDR"
  type        = string
}

variable "gke_services_subnet" {
  description = "Subnet CIDR"
  type        = string
}

variable "project_id" {
  description = "Project id"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "vpc" {
  description = "VPC name"
  type        = string
}

variable "zone" {
  description = "GCP zone"
  type        = string
}
