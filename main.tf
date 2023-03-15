module "gh-runner-gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.gcp_project_id
  name                       = "${var.gke_cluster_name}-${var.gke_cluster_env}"
  region                     = var.gcp_region
  regional                   = var.gcp_regional
  ip_range_pods              = ""
  ip_range_services          = ""
  zones                      = var.gcp_zones
  network                    = var.gke_network
  subnetwork                 = var.gke_subnetwork
  network_policy             = false
  horizontal_pod_autoscaling = false
  filestore_csi_driver       = false
  create_service_account     = true

  node_pools = [
    {
      name                   = "${var.gke_cluster_name}-${var.gke_cluster_env}-node-pool"
      machine_type           = "e2-medium"
      min_count              = 1
      max_count              = 100
      local_ssd_count        = 0
      spot                   = false
      disk_size_gb           = 100
      disk_type              = "pd-standard"
      image_type             = "COS_CONTAINERD"
      enable_gcfs            = false
      enable_gvnic           = false
      auto_repair            = true
      auto_upgrade           = true
      create_service_account = true
      preemptible            = false
      initial_node_count     = 1
    },
  ]

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "${var.gke_cluster_name}-${var.gke_cluster_env}-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "${var.gke_cluster_name}-${var.gke_cluster_env}-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "${var.gke_cluster_name}-${var.gke_cluster_env}-node-pool",
    ]
  }
}
