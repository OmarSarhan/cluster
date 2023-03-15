provider "google" {
  project     = var.project_id
  region      = var.location
  credentials = base64decode(var.google_sa)
}
