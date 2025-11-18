locals {
  environment_config = {
    "dev"     = var.dev_config
    "test"    = var.test_config
    "prod"    = var.prod_config
    "dr-prod" = var.dr_prod_config
  }
  configuration = local.environment_config[var.environment][var.application]
}

module "app" {
  source  = "app.terraform.io/cpchem/asg-application/azurerm"
  version = "0.8.8"

  count = contains(["dev", "test", "prod"], var.environment) ? 1 : 0

  environment                            = var.environment
  application                            = var.application
  application_support_group_abbreviation = local.configuration.application_support_group_abbreviation
  location                               = local.configuration.location
  cost_center                            = local.configuration.cost_center
  department                             = local.configuration.department
  description                            = local.configuration.description
  managed_by                             = local.configuration.managed_by
  application_developer_ad_group_id      = local.configuration.application_developer_ad_group_id
  application_developer_pim_group_id     = local.configuration.application_developer_pim_group_id
  #application_support_group_name              = local.configuration.application_support_group_name
  sql_server_id                          = try(data.tfe_outputs.shared.nonsensitive_values.sql_server_id, null)
  elastic_pool_id                        = try(data.tfe_outputs.shared.nonsensitive_values.elastic_pool_id, null)
  database_configuration                 = local.configuration.database_configuration
  tenant_id                              = data.azurerm_subscription.current.tenant_id
  application_abbrevation                = local.configuration.application_abbrevation
  resource_group_name                    = data.tfe_outputs.shared.nonsensitive_values.resource_group_name
  asp_id                                 = try(data.tfe_outputs.shared.nonsensitive_values.asp_id, "")
  cdn_sa_deployment_service_principal_id = local.configuration.cdn_sa_deployment_service_principal_id
  vnet_subnet_id                         = try(data.tfe_outputs.shared.nonsensitive_values.subnet_id, null)
  storage_account_name                   = try(data.tfe_outputs.shared.nonsensitive_values.storage_account_name, "")
  primary_access_key                     = try(data.tfe_outputs.shared.values.storage_account_access_key, null)
  keyvault_configuration                 = local.configuration.keyvault_configuration
  webapp_configuration                   = local.configuration.webapp_configuration
  functionapp_configuration              = local.configuration.functionapp_configuration
  cdn_configuration                      = local.configuration.cdn_configuration
  application_storage_configuration      = local.configuration.application_storage_configuration
  adf_configuration                      = local.configuration.adf_configuration
  logicapp_configuration                 = local.configuration.logicapp_configuration
  tf_cloud_agent_role_assignments        = try(local.configuration.tf_cloud_agent_role_assignments, null)

  providers = {
    azurerm             = azurerm
    azurerm.server-team = azurerm.server-team
  }
}

module "app-dr" {
  source  = "app.terraform.io/cpchem/asg-application-dr/azurerm"
  version = "0.3.0"

  count = var.environment == "dr-prod" ? 1 : 0

  environment                                  = var.environment
  application                                  = var.application
  application_support_group_abbreviation       = local.configuration.application_support_group_abbreviation
  location                                     = local.configuration.location
  cost_center                                  = local.configuration.cost_center
  department                                   = local.configuration.department
  description                                  = local.configuration.description
  managed_by                                   = local.configuration.managed_by
  application_developer_ad_group_id            = local.configuration.application_developer_ad_group_id
  application_developer_pim_group_id           = local.configuration.application_developer_pim_group_id
  cdn_endpoint_id                              = try(data.tfe_outputs.prod_application[0].nonsensitive_values.cdn_endpoint_id, null)
  cdn_storage_container_id                     = try(data.tfe_outputs.prod_application[0].nonsensitive_values.cdn_storage_container_id, null)
  cdn_sa_deployment_service_principal_id       = local.configuration.cdn_sa_deployment_service_principal_id
  cdn_endpoint_deployment_service_principal_id = local.configuration.cdn_endpoint_deployment_service_principal_id
  sql_server_id                                = try(data.tfe_outputs.shared.nonsensitive_values.sql_server_id, null)
  elastic_pool_id                              = try(data.tfe_outputs.shared.nonsensitive_values.elastic_pool_id, null)
  sql_replica_source                           = data.tfe_outputs.prod_application[0].nonsensitive_values.application_database_idset
  tenant_id                                    = data.azurerm_subscription.current.tenant_id
  application_abbrevation                      = local.configuration.application_abbrevation
  resource_group_name                          = try(data.tfe_outputs.shared.nonsensitive_values.resource_group_name, null)
  asp_id                                       = try(data.tfe_outputs.shared.nonsensitive_values.asp_id, "")
  vnet_subnet_id                               = try(data.tfe_outputs.shared.nonsensitive_values.subnet_id, "")
  storage_account_name                         = try(data.tfe_outputs.shared.nonsensitive_values.storage_account_name, "")
  //origin_path                            = local.configuration.origin_path
  //storage_container_name                 = local.configuration.storage_container_name
  database_configuration    = local.configuration.database_configuration
  keyvault_configuration    = local.configuration.keyvault_configuration
  webapp_configuration      = local.configuration.webapp_configuration
  functionapp_configuration = local.configuration.functionapp_configuration

  providers = {
    azurerm             = azurerm
    azurerm.server-team = azurerm.server-team
  }

}

