provider "google" {
  project     = var.project_id
  region      = var.location
  credentials = var.google_sa
}
