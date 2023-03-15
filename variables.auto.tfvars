prefix = "gke"
region = "europe-west2"

vpc = {
  subnetwork    = "main-k8s"
  pod_range     = "cluster-range"
  service_range = "service-range"
}

firewall_ports = ["9443", "15017"]
