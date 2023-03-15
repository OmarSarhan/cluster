module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 21.2"

  project_id         = module.project_k8s.project_id
  network_project_id = var.host_project_id
  name               = "${var.prefix}-${var.env}-cluster"
  region             = var.region
  zones              = ["${var.region}-a", "${var.region}-b", "${var.region}-c"]
  release_channel    = "REGULAR"

  network           = "${var.prefix}-${var.env}-vpc"
  subnetwork        = var.vpc.subnetwork    #"main-k8s"
  ip_range_pods     = var.vpc.pod_range     #"cluster-range"
  ip_range_services = var.vpc.service_range #"service-range"

  cluster_resource_labels = { "mesh_id" : "proj-${module.project_k8s.project_id}" }
  identity_namespace      = "${module.project_k8s.project_id}.svc.id.goog"

  http_load_balancing             = true
  network_policy                  = false
  horizontal_pod_autoscaling      = true
  filestore_csi_driver            = false
  add_cluster_firewall_rules      = true
  firewall_inbound_ports          = var.firewall_ports
  enable_shielded_nodes           = true
  initial_node_count              = 3
  enable_vertical_pod_autoscaling = true

  create_service_account = false
  #service_account            = ""
  #compute_engine_service_account = ""

  cluster_autoscaling = {
    autoscaling_profile = "BALANCED"
    enabled             = false
    gpu_resources       = []
    max_cpu_cores       = 0
    max_memory_gb       = 0
    min_cpu_cores       = 0
    min_memory_gb       = 0
  }

  # once get building pools working .. .then allow env change of machine types
  node_pools = [
    {
      name            = "default-node-pool"
      machine_type    = "e2-medium"
      node_locations  = "${var.region}-a,${var.region}-b,${var.region}-c"
      min_count       = 1
      max_count       = 100
      local_ssd_count = 0
      spot            = false
      disk_size_gb    = 40
      disk_type       = "pd-standard"
      image_type      = "COS_CONTAINERD"
      enable_gcfs     = false
      enable_gvnic    = false
      auto_repair     = true
      auto_upgrade    = true
      service_account = "${module.project_k8s.project_number}-compute@developer.gserviceaccount.com"
      #"project-service-account@${module.service-project_k8s.project_id}.iam.gserviceaccount.com"
      preemptible        = false
      initial_node_count = 3
      node_count         = 3
      auto_upgrade       = true
      autoscaling        = true
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}

module "asm" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  project_id       = module.project_k8s.project_id
  cluster_name     = module.gke.name
  cluster_location = module.gke.location
  #cluster_endpoint  = module.gke.endpoint
  enable_cni                = true
  enable_fleet_registration = true
  enable_mesh_feature       = true
  enable_vpc_sc             = true
  internal_ip               = false

  #asm_dir           = "asm-dir-${module.gke.name}"

}
