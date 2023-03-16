resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.location
  initial_node_count = 1
}

resource "google_container_cluster" "maintenance_policy" {
  daily_maintenance_window {
    start_time = "03:00"
    end_time   = "05:00"
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
