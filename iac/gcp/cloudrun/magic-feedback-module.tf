module "api_gateway" {
  source = "./modules/api-gateway"
  apis = [
    {
      name         = "mf-api-gw"
      api_id       = "mf-api-gw"
      config_id    = "mf-api-gw-config"
      openapi_file = filebase64("./openapi/mf-module.yaml")
      project      = local.project_id
      region       = "us-east4"
    }
  ]
}