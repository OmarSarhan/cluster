provider "google" {
  credentials = TF_VAR_GOOGLE_SA
  project     = var.gcp_project_id
  region      = var.gcp_region
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}
