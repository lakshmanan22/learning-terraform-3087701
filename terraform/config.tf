
dev_config = {
  crm = {
    application_support_group_abbreviation = "SCC"
    application_abbrevation                = "CRM"
    location                               = "southcentralus"
    cost_center                            = "P3603"
    department                             = "Business Transformation"
    description                            = "Business Transformation Development Research and Technology Resources"
    managed_by                             = "DT"
    application_developer_ad_group_id      = ""
    application_developer_pim_group_id     = ""
    cdn_sa_deployment_service_principal_id = ""
    tf_cloud_agent_role_assignments        = {}
    database_configuration = {
      auto_pause_delay_in_minutes = -1
      min_capacity                = 0
      create_mode                 = "Default"
      database_name               = "sqldbCPCscus-DT-App-SugarCRM-Dev"
      elastic_pool_enabled        = true
      max_size_gb                 = 100
      sku_name                    = "ElasticPool"
      storage_account_type        = "Local"
      diagnostics                 = false
    }
    keyvault_configuration = {
      /*
      kv_pe_ip                    = ""
      kv_application_abbreviation = "" // no more than 6 chars
      keyvault_deployment_service_principal_id = ""
      */
    }
    webapp_configuration = {
      /*       web_app_pe_ip                          = ""
      diagnostics                            = false
      webapp_deployment_service_principal_id = "" */
    }
    functionapp_configuration = {
      /*  function_app_pe_ip = "10.17.2.16" //snetSCUSdt-10-17-2-0-24-app-fnt-dev
      diagnostics        = false */
    }
    cdn_configuration = {
      /*       cdn_custom_domain                            = ""
      origin_path                                  = "/"
      storage_container_name                       = ""
      application_two_letter_abbrevation           = null
      cdn_endpoint_deployment_service_principal_id = "" */
    }
    application_storage_configuration = {
      /*       storage_container_name                                   = null
      application_sa_container_deployment_service_principal_id = "" */
    }

    adf_configuration = {}

    logicapp_configuration = {}
  }

  ecom = {
    application_support_group_abbreviation = "SCC"
    application_abbrevation                = "ECOM"
    location                               = "southcentralus"
    cost_center                            = "P3603"
    department                             = "Business Transformation"
    description                            = "Business Transformation Development Research and Technology Resources"
    managed_by                             = "DT"
    application_developer_ad_group_id      = ""
    application_developer_pim_group_id     = ""
    cdn_sa_deployment_service_principal_id = ""
    tf_cloud_agent_role_assignments = {
      "sql_db_contributor-to-ecom-db" = {
        scope        = "/subscriptions/852654d0-8d03-4e37-865c-e8ffd0357374/resourceGroups/rgAM-App-SCC-Dev/providers/Microsoft.Sql/servers/sqlcpcscusam-app-scc-gen-dev"
        principal_id = "de769f1e-a9fc-4ccf-9369-4c85eade5b0b" #Terraform cloud Agent - Digital Test
        role         = "SQL DB Contributor"
      }
    }
    database_configuration = {
      auto_pause_delay_in_minutes = -1
      min_capacity                = 0
      create_mode                 = "Default"
      database_name               = "sqldbCPCscus-DT-App-Ecom-Dev"
      elastic_pool_enabled        = true
      max_size_gb                 = 10
      sku_name                    = "ElasticPool"
      storage_account_type        = "Local"
      diagnostics                 = false
    }
    keyvault_configuration = {
      /*
      kv_pe_ip                    = ""
      kv_application_abbreviation = "" // no more than 6 chars
      keyvault_deployment_service_principal_id = ""
      */
    }
    webapp_configuration = {
      /*       web_app_pe_ip                          = ""
      diagnostics                            = false
      webapp_deployment_service_principal_id = "" */
    }
    functionapp_configuration = {
      /*  function_app_pe_ip = "10.17.2.16" //snetSCUSdt-10-17-2-0-24-app-fnt-dev
      diagnostics        = false */
    }
    cdn_configuration = {
      /*       cdn_custom_domain                            = ""
      origin_path                                  = "/"
      storage_container_name                       = ""
      application_two_letter_abbrevation           = null
      cdn_endpoint_deployment_service_principal_id = "" */
    }
    application_storage_configuration = {
      /*       storage_container_name                                   = null
      application_sa_container_deployment_service_principal_id = "" */
    }

    adf_configuration = {}

    logicapp_configuration = {}
  }

  tz = {
    application_support_group_abbreviation = "SCC"
    application_abbrevation                = "TZ"
    location                               = "southcentralus"
    cost_center                            = "P3603"
    department                             = "Business Transformation"
    description                            = "Business Transformation Development Research and Technology Resources"
    managed_by                             = "DT"
    application_developer_ad_group_id      = ""
    application_developer_pim_group_id     = ""
    cdn_sa_deployment_service_principal_id = ""
    tf_cloud_agent_role_assignments        = {}
    database_configuration = {
      auto_pause_delay_in_minutes = -1
      min_capacity                = 0
      create_mode                 = "Default"
      database_name               = "sqldbCPCscus-DT-App-TZ-Dev"
      elastic_pool_enabled        = true
      max_size_gb                 = 10
      sku_name                    = "ElasticPool"
      storage_account_type        = "Local"
      diagnostics                 = false
    }
    keyvault_configuration = {
      /*
      kv_pe_ip                    = ""
      kv_application_abbreviation = "" // no more than 6 chars
      keyvault_deployment_service_principal_id = ""
      */
    }
    webapp_configuration = {
      /*       web_app_pe_ip                          = ""
      diagnostics                            = false
      webapp_deployment_service_principal_id = "" */
    }
    functionapp_configuration = {
      /*  function_app_pe_ip = "10.17.2.16" //snetSCUSdt-10-17-2-0-24-app-fnt-dev
      diagnostics        = false */
    }
    cdn_configuration = {
      /*       cdn_custom_domain                            = ""
      origin_path                                  = "/"
      storage_container_name                       = ""
      application_two_letter_abbrevation           = null
      cdn_endpoint_deployment_service_principal_id = "" */
    }
    application_storage_configuration = {
      /*       storage_container_name                                   = null
      application_sa_container_deployment_service_principal_id = "" */
    }

    adf_configuration = {}

    logicapp_configuration = {}
  }
}
