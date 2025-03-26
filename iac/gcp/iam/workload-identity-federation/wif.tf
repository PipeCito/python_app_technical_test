data "google_service_account" "github" {
  account_id = "github-oidc-test"
}

resource "google_iam_workload_identity_pool" "github-oidc-test" {
  workload_identity_pool_id = "github-oidc-test"
  display_name              = "github-oidc-test"
  description               = "Identity Pool to Automate and Secure Github Actions Connecting to GCP"
  disabled                  = false
}

resource "google_iam_workload_identity_pool_provider" "github-oidc-test" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github-oidc-test.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-oidc-test"
  display_name                       = "github-oidc-test"
  description                        = "OIDC Identity Pool to Automate and Secure Github Actions Connecting to GCP"
  disabled                           = false
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_condition = "assertion.repository == \"PipeCito/python_app_technical_test\""
}

resource "google_service_account_iam_binding" "gcp-service-accounts-workload-identity-github" {
  depends_on = [ google_iam_workload_identity_pool_provider.github-oidc-test ]
  service_account_id = data.google_service_account.github.id
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/projects/650911635508/locations/global/workloadIdentityPools/github-oidc-test/attribute.repository/PipeCito/python_app_technical_test",
  ]
}