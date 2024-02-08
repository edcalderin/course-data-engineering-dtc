variable "project" {
  description = "project"
  default     = "terraform-demo-413217"
}

variable "region" {
  description = "Region name"
  default     = "us-central1"
}
variable "bq_dataset_name" {
  default     = "demo_dataset"
  description = "My BigQuery Dataset Name"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "terraform-demo-413217-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}