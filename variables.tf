# env vars
variable "prefix" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west2"
}

# group vars
variable "env" {
  type = string
}

variable "org_id" {
  type = string
}

variable "billing_account" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "host_project_id" {
  type = string
}

# other env vars
variable "vpc" {
  type = object({
    subnetwork    = string
    pod_range     = string
    service_range = string
  })
}

variable "firewall_ports" {
  type = list(string)
}
