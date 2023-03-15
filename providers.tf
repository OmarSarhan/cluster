provider "google" {
  project     = "cluster-380700"
  region      = var.location
  credentials = var.google_sa
}
