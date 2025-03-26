# SERVICE ACCOUNT
data "google_service_account" "github" {
  account_id = "github-oidc-test"
}

resource "google_artifact_registry_repository_iam_member" "member" {
  project = var.project_id
  location = google_artifact_registry_repository.magic-feedback-repo.location
  repository = google_artifact_registry_repository.magic-feedback-repo.name
  role = "roles/artifactregistry.writer"
  member = data.google_service_account.github.member
}