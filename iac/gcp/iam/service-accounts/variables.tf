variable "project_id" {
  description = "Google Cloud ProjectID"
  default     = "elaborate-baton-340602"
}

variable "gcp_service_accounts" {
  description = "Google Cloud Service Accounts creation"
  type = list(object({
    id    = string
    roles = list(string)
  }))
  default = [
    {
      id = "github-oidc-test"
      roles = [
        "roles/run.admin",
        "roles/iam.serviceAccountUser"
      ]
    }
  ]
}