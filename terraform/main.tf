terraform {
    backend "gcs" {
        bucket = "self-study-platform-terraform"
        prefix = "/terraform-state"
    }
}