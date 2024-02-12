# GKE ML Cluster Deployment

This folder contains the Terraform configuration required to deploy the supporting GKE cluster to your Google Cloud Project.

## Requirements

* [Terraform](https://developer.hashicorp.com/terraform/downloads) configured and installed
* [gcloud](https://cloud.google.com/sdk/gcloud/) configured and authenticated account (`gcloud auth application-default login`)

## Instructions

1. Copy `terraform.tfvars.example` to `terraform.tfvars`, updating variables as appropriate.
2. Run `terraform init`
3. Run `terraform apply`
4. When prompted enter your Google Cloud Project ID