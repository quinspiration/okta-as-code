terraform {
  required_version = ">= 1.9.0"

  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 7.0"
    }
  }

  backend "gcs" {
    bucket = "okta-as-code-tf-state"
    prefix = "okta"
  }
}

provider "okta" {
  org_name = var.okta_org_name
  base_url = var.okta_base_url
}