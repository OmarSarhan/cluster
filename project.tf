
module "project_k8s" {
  source = "terraform-google-modules/project-factory/google"

  name              = "${var.prefix}-${var.env}-k8s"
  random_project_id = true
  org_id            = var.org_id
  billing_account   = var.billing_account
  folder_id         = var.folder_id

  svpc_host_project_id = var.host_project_id

  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "dataproc.googleapis.com",
    "dataflow.googleapis.com",
    "servicenetworking.googleapis.com",
    "gkehub.googleapis.com",
    "anthosconfigmanagement.googleapis.com",
    "mesh.googleapis.com",
    "meshconfig.googleapis.com",
    "meshca.googleapis.com",
    "gkehub.googleapis.com",
    "iam.googleapis.com",
    "monitoring.googleapis.com",
    "cloudtrace.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "run.googleapis.com",
    "containerregistry.googleapis.com",
    "artifactregistry.googleapis.com",
    "storage.googleapis.com",
    "anthos.googleapis.com",
    "meshtelemetry.googleapis.com",
    "iamcredentials.googleapis.com",
    "gkeconnect.googleapis.com",
    "logging.googleapis.com",
  ]

  shared_vpc_subnets = [
    "projects/${var.host_project_id}/regions/${var.region}/subnetworks/${var.vpc.subnetwork}",
  ]
}
