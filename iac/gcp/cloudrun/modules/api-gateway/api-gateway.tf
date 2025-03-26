resource "google_api_gateway_api" "api" {
  provider = google-beta
  for_each = { for api in var.apis : api.api_id => api }
  api_id   = each.value.api_id
  project  = each.value.project
}

resource "google_api_gateway_api_config" "api_config" {
  provider      = google-beta
  for_each      = { for api in var.apis : api.api_id => api }
  api           = google_api_gateway_api.api[each.key].api_id
  project       = each.value.project
  api_config_id = each.value.config_id

  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = each.value.openapi_file
    }
  }

  depends_on = [google_api_gateway_api.api]
}

resource "google_api_gateway_gateway" "gateway" {
  provider   = google-beta
  for_each   = { for api in var.apis : api.api_id => api }
  gateway_id = each.value.name
  project    = each.value.project
  api_config = google_api_gateway_api_config.api_config[each.key].id
  region     = each.value.region

  depends_on = [google_api_gateway_api_config.api_config]
}