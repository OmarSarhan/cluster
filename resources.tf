resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.location
  initial_node_count = 1
  maintenance_policy {
    recurring_window {
      start_time = "2019-08-01T02:00:00Z"
      end_time   = "2019-08-01T06:00:00Z"
      recurrence = "FREQ=DAILY"
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name           = "${var.cluster_name}-node-pool"
  location       = var.location
  project        = var.project_id
  version        = var.worker_nodes_version
  cluster        = google_container_cluster.primary.name
  node_locations = var.node_locations
  node_count     = var.worker_nodes_count

  node_config {
    disk_size_gb = var.worker_nodes_disk_size
    machine_type = var.worker_node_type
    preemptible  = true
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

resource "local_file" "statesave" {
  content  = data.terraform_remote_state.statesave.outputs.greeting
  filename = "${path.module}/outputs.txt"
}
