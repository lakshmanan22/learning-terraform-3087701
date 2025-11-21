dev_config = {
  drpolymer = {
    #application_support_group_name              = "Research & Technology"
    application_support_group_abbreviation = "RT"
    location                               = "southcentralus"
    cost_center                            = "P3603"
    department                             = "Business Transformation"
    description                            = "Business Transformation Development Research and Technology Resources"
    managed_by                             = "DT"
    application_developer_ad_group_id      = "54de110d-6f7f-4e41-83ed-ffa4db4c231d" // AZ-HQ-AppDev-RT-Admins
    application_developer_pim_group_id     = "c5b3a953-4d20-4996-b559-bbd12679acf4" // PIM group used for resource level permissions
    cdn_sa_deployment_service_principal_id = "275ce371-9040-419e-85e5-0c28ab23f957"
    tf_cloud_agent_role_assignments        = {}
    database_configuration = {
      auto_pause_delay_in_minutes = -1
      min_capacity                = 0
      database_name               = "sqldbCPCscusAM-App-RT-Drpolymer-Dev"
      create_mode                 = "Default"
      elastic_pool_enabled        = false
      max_size_gb                 = 2 #10
      sku_name                    = "Basic"
      storage_account_type        = "Local"
      diagnostics                 = false
    }
    keyvault_configuration = {
      /*       key_vault_sku_name                       = "standard"
      kv_application_abbreviation              = "DRPoly"
      kv_pe_ip                                 = "10.17.0.11"
      diagnostics                              = false
      keyvault_deployment_service_principal_id = "c0401762-ee1f-4dc0-9370-0b2ec00a2b82" */
    }
    webapp_configuration = {
      web_app_pe_ip    = null
      diagnostics      = false
      service_plan_key = "appservices"
      #webapp_deployment_service_principal_id = "c0401762-ee1f-4dc0-9370-0b2ec00a2b82"
      app_role_assignments = {
        "Website-Contributor-GitHub-Actions-cpchem-nebula-backend" = {
          role_definition_name = "Website Contributor"
          principal_id         = "c0401762-ee1f-4dc0-9370-0b2ec00a2b82"
        },
        "Website-Contributor-PIM" = {
          role_definition_name = "Website Contributor"
          principal_id         = "c5b3a953-4d20-4996-b559-bbd12679acf4"
        },
      }
    }
    functionapp_configuration = {
      function_app_pe_ip = null
      diagnostics        = false
      service_plan_key   = "appservices"
      #functionapp_deployment_service_principal_id = "3e5283ac-04ee-4a40-8f65-2d1bb37115f9"
      function_app_role_assignments = {
        "Website-Contributor-PIM" = {
          role_definition_name = "Website Contributor"
          principal_id         = "c5b3a953-4d20-4996-b559-bbd12679acf4"
        },
        "Website-Contributor-GitHub-Actions-cpchem-nebula-functions" = {
          role_definition_name = "Website Contributor"
          principal_id         = "3e5283ac-04ee-4a40-8f65-2d1bb37115f9"
        },
      }
    }
    cdn_configuration = {
      origin_path                                  = "/drpolymer"
      cdn_custom_domain                            = null
      storage_container_name                       = "drpolymer"
      application_two_letter_abbrevation           = "dp"
      cdn_endpoint_deployment_service_principal_id = "c0401762-ee1f-4dc0-9370-0b2ec00a2b82"
    }
    application_storage_configuration = {
      storage_container_name                                   = null
      application_sa_container_deployment_service_principal_id = "c0401762-ee1f-4dc0-9370-0b2ec00a2b82"
    }
    application_abbrevation = "DRPoly"

    adf_configuration = {}

    logicapp_configuration = {}
  }
}
