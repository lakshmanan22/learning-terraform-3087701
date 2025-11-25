locals {

}

module "azurerm_function_app" {
  source  = "app.terraform.io/cpchem/cpc-base-linux-function-app/azurerm"
  version = "0.1.6"

  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id
  site_config = {
    container_registry_use_managed_identity = false
    always_on                               = true
    default_documents = [
      "Default.htm",
      "Default.html",
      "Default.asp",
      "index.htm",
      "index.html",
      "iisstart.htm",
      "default.aspx",
      "index.php",
    ]
    ftps_state                  = "Disabled"
    http2_enabled               = true
    ip_restriction              = null
    managed_pipeline_mode       = "Integrated"
    minimum_tls_version         = "1.2"
    worker_count                = 1
    remote_debugging_enabled    = false
    remote_debugging_version    = null
    scm_ip_restriction          = null
    scm_use_main_ip_restriction = false
    use_32_bit_worker           = false
    vnet_route_all_enabled      = true
    websockets_enabled          = false
    cors = {
      allowed_origins = [
        "https://portal.azure.com",
      ]
      support_credentials = false
    }
    application_stack = {
      dotnet_version              = "8.0"
      use_custom_runtime          = null
      use_dotnet_isolated_runtime = true
    }
  }
  app_settings                       = null
  auth_settings                      = null
  auth_settings_v2                   = null
  backup                             = null
  builtin_logging_enabled            = false
  client_certificate_enabled         = false
  client_certificate_mode            = "Required"
  client_certificate_exclusion_paths = null
  connection_string                  = null
  daily_memory_time_quota            = null
  enabled                            = true
  content_share_force_disabled       = null
  functions_extension_version        = null
  https_only                         = true
  identity = {
    type = "SystemAssigned"
  }
  key_vault_reference_identity_id = null
  storage_account                 = null
  sticky_settings                 = null
  storage_account_access_key      = null
  storage_uses_managed_identity   = null
  storage_key_vault_secret_id     = null
  zip_deploy_file                 = null
  timeouts                        = null
  public_network_access_enabled   = false
  storage_account_name            = var.storage_account_name
  virtual_network_subnet_id       = var.virtual_network_subnet_id
  tags                            = var.tags
}

#-------------------------------------------
# Function App Private endpoint
#-------------------------------------------
resource "azurerm_private_endpoint" "pe_function_app" {
  name                          = "pe${module.azurerm_function_app.name}"
  resource_group_name           = "rgDT-Network-${title(var.environment)}"
  location                      = var.location
  subnet_id                     = var.private_endpoint_subnet_id
  custom_network_interface_name = "pe${module.azurerm_function_app.name}-nic"
  private_service_connection {
    name                           = "pe${module.azurerm_function_app.name}"
    private_connection_resource_id = module.azurerm_function_app.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }
  private_dns_zone_group {
    private_dns_zone_ids = [
    "/subscriptions/9afa9e1f-5273-4c90-888e-8164a9c052e3/resourceGroups/rgAM-Network/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"]
    name = "default"
  }

  tags = var.network_tags

  depends_on = [module.azurerm_function_app_diagnostic_setting]
}



#-------------------------------------------
# Function App Diagnsotic Setting
#-------------------------------------------
module "azurerm_function_app_diagnostic_setting" {
  source  = "app.terraform.io/cpchem/cpc-base-monitor-diagnostic-setting/azurerm"
  version = "0.1.2"

  count                      = var.diagnostics_enabled ? 1 : 0
  name                       = var.diagnostics_name
  target_resource_id         = module.azurerm_function_app.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  enabled_log = {
    category = ["FunctionAppLogs"]
  }
  metric = {
    category = ["AllMetrics"]
  }
}

#-------------------------------------------
# Function App Role Assignments
#-------------------------------------------
module "azurerm_role_assignment_function_app" {
  source  = "app.terraform.io/cpchem/cpc-base-role-assignment/azurerm"
  version = "0.1.5"

  for_each             = { for i, obj in var.function_app_role_assignments : i => obj }
  scope                = module.azurerm_function_app.id
  principal_id         = each.value["principal_id"]
  role_definition_name = each.value["role_definition_name"]
  principal_type       = try(each.value["principal_type"], null)
  display_name         = try(each.value["display_name"], null)
}
