terraform {
  required_version = ">= 1.0.7"
  backend "http" {}

  required_providers {

    google = {
      source = "hashicorp/google"
    }

    google-beta = {
      source = "hashicorp/google-beta"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    gitlab = {
      source = "gitlabhq/gitlab"
    }

    random = {
      source = "hashicorp/random"
    }

  }

}
