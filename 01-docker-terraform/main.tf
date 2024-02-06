terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.14.0"
    }
  }
}

provider "google" {
  project = "terraform-demo-413217"
  region  = "us-central1"
  credentials = "./keys/credentials.json"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "terraform-demo-413217-terra-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}