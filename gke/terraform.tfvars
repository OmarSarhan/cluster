cluster_name           = "production-cluster"
location               = "europe-west2"
project_id             = "grounded-will-296203"
subnetwork             = "default"
istio_enabled          = "false"
istio_auth             = "AUTH_MUTUAL_TLS"
node_pool_name         = "production-cluster-node-pool-1"
master_version         = "1.24.9-gke.3200"
worker_nodes_version   = "1.24.9-gke.3200"
node_locations         = ["europe-west2-a", "us-east1-b"]
worker_nodes_count     = "1"
worker_nodes_disk_size = "50"
worker_node_type       = "e2-medium"