variable "project_id" {
  description = "Google Cloud ProjectID"
  default     = "elaborate-baton-340602"
}

variable "apis" {
  description = "List of API Gateways to create."
  type = list(object({
    name         = string
    api_id       = string
    config_id    = string
    openapi_file = string
    project      = string
    region       = string
  }))
}