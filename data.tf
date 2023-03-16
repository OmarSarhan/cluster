data "terraform_remote_state" "statesave" {
  backend = "gcs"
  config = {
    bucket      = "cluster-terraform-state"
    prefix      = "prod"
    credentials = var.google_sa
  }
}

