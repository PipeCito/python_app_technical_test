resource "google_artifact_registry_repository" "magic-feedback-repo" {
  repository_id = "magic-feedback-app"
  location      = "us-east4"
  format        = "DOCKER"
  description   = "My Artifact Registry Docker Repository"
  project       = var.project_id
}
