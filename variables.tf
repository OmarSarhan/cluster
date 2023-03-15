variable "TF_VAR_gcp_credentials" {
  type        = string
  description = "SA for GCP"
}

variable "gcp_project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "gcp_region" {
  type        = string
  description = "GCP Region"
}

variable "gcp_regional" {
  type        = string
  description = "GCP Region"
}

variable "gke_cluster_name" {
  type        = string
  description = "GKE Cluster Name"
}

variable "gke_cluster_env" {
  type        = string
  description = "GKE Cluster Environment"
}

variable "gcp_zones" {
  type        = list(string)
  description = "List of GCP Zones for GKE"
}

variable "gke_network" {
  type        = string
  description = "Network for GKE"
}

variable "gke_subnetwork" {
  type        = string
  description = "Subnetwork for GK"
}
