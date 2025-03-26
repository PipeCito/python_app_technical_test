resource "google_project_iam_member" "gcp-service-accounts-bindings" {
  depends_on = [google_service_account.gcp-service-accounts]
  for_each = {
    for pair in flatten([
      for sa in var.gcp_service_accounts : [ # sa -> service_account
        for role in sa.roles :
        {
          entity = sa.id
          role   = role
        }
      ]
    ]) : "${pair.entity}__${pair.role}" => pair
  }
  member  = google_service_account.gcp-service-accounts["${each.value.entity}"].member
  project = var.project_id
  role    = each.value.role
  lifecycle {
    ignore_changes = []
  }
}

resource "google_service_account" "gcp-service-accounts" {
  for_each     = { for sa in var.gcp_service_accounts : sa.id => sa }
  project      = var.project_id
  account_id   = each.value.id
  display_name = each.value.id
}
