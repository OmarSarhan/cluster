terraform {
  backend "gcs" {
    bucket      = "cluster-terraform-states"
    credentials = "${var.google_sa}"
    prefix      = "terraform/state"
  }
}
