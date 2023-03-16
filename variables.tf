variable "cluster_name" {}

variable "location" {}

variable "project_id" {}

variable "subnetwork" {}

variable "worker_nodes_version" {}

variable "node_locations" {
  type = list(any)
}

variable "worker_nodes_count" {}

variable "worker_nodes_disk_size" {}

variable "worker_node_type" {}

variable "google_sa" {}


