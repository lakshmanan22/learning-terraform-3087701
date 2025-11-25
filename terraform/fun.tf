#-------------------------------------------
# Resource Module Definition
#-------------------------------------------
resource "azurerm_linux_function_app" "this" {
  location                      = var.location
  name                          = var.name
  resource_group_name           = var.resource_group_name
  service_plan_id               = var.service_plan_id
  public_network_access_enabled = var.public_network_access_enabled

  site_config {
    always_on                              = try(var.site_config.always_on, null)
    api_definition_url                     = try(var.site_config.api_definition_url, null)
    api_management_api_id                  = try(var.site_config.api_management_api_id, null)
    app_command_line                       = try(var.site_config.app_command_line, null)
    app_scale_limit                        = try(var.site_config.app_scale_limit, null)
    application_insights_connection_string = try(var.site_config.application_insights_connection_string, null)
    application_insights_key               = try(var.site_config.application_insights_key, null)
    scm_ip_restriction_default_action      = try(var.site_config.scm_ip_restriction_default_action, null)
    ip_restriction_default_action          = try(var.site_config.ip_restriction_default_action, null)


    dynamic "application_stack" {
      for_each = toset(try(var.site_config.application_stack, null) != null ? ["*"] : [])
      content {
        dynamic "docker" {
          for_each = toset(try(var.site_config.application_stack.docker, null) != null ? ["*"] : [])
          content {
            registry_url      = var.site_config.application_stack.docker.registry_url
            image_name        = var.site_config.application_stack.docker.image_name
            image_tag         = var.site_config.application_stack.docker.image_tag
            registry_username = try(var.site_config.application_stack.docker.registry_username, null)
            registry_password = try(var.site_config.application_stack.docker.registry_password, null)
          }
        }
        dotnet_version              = try(var.site_config.application_stack.dotnet_version, null)
        use_dotnet_isolated_runtime = try(var.site_config.application_stack.use_dotnet_isolated_runtime, null)
        powershell_core_version     = try(var.site_config.application_stack.powershell_core_version, null)
        java_version                = try(var.site_config.application_stack.java_version, null)
        node_version                = try(var.site_config.application_stack.node_version, null)
        python_version              = try(var.site_config.application_stack.python_version, null)
        use_custom_runtime          = try(var.site_config.application_stack.use_custom_runtime, null)
      }
    }

    dynamic "app_service_logs" {
      for_each = toset(try(var.site_config.app_service_logs, null) != null ? ["*"] : [])
      content {
        disk_quota_mb         = try(var.site_config.app_service_logs.disk_quota_mb, null)
        retention_period_days = try(var.site_config.app_service_logs.retention_period_days, null)
      }
    }

    container_registry_managed_identity_client_id = try(var.site_config.container_registry_managed_identity_client_id, null)
    container_registry_use_managed_identity       = try(var.site_config.container_registry_use_managed_identity, null)

    dynamic "cors" {
      for_each = toset(try(var.site_config.cors, null) != null ? ["*"] : [])
      content {
        allowed_origins     = try(var.site_config.cors.allowed_origins, null)
        support_credentials = try(var.site_config.cors.support_credentials, null)
      }
    }

    default_documents                 = try(var.site_config.default_documents, null)
    elastic_instance_minimum          = try(var.site_config.elastic_instance_minimum, null)
    ftps_state                        = try(var.site_config.ftps_state, "Disabled")
    health_check_path                 = try(var.site_config.health_check_path, null)
    health_check_eviction_time_in_min = try(var.site_config.health_check_eviction_time_in_min, null)
    http2_enabled                     = try(var.site_config.http2_enabled, true)

    dynamic "ip_restriction" {
      for_each = toset(try(var.site_config.ip_restriction, null) != null ? ["*"] : [])
      content {
        action = try(var.site_config.ip_restriction.action, null)

        dynamic "headers" {
          for_each = toset(try(var.site_config.ip_restriction.headers, null) != null ? ["*"] : [])
          content {
            x_azure_fdid      = try(var.site_config.ip_restriction.headers.x_azure_fdid, null)
            x_fd_health_probe = try(var.site_config.ip_restriction.headers.x_fd_health_probe, null)
            x_forwarded_for   = try(var.site_config.ip_restriction.headers.x_forwarded_for, null)
            x_forwarded_host  = try(var.site_config.ip_restriction.headers.x_forwarded_host, null)
          }
        }

        ip_address                = try(var.site_config.ip_restriction.ip_address, null)
        name                      = try(var.site_config.ip_restriction.name, null)
        priority                  = try(var.site_config.ip_restriction.priority, null)
        service_tag               = try(var.site_config.ip_restriction.service_tag, null)
        virtual_network_subnet_id = try(var.site_config.ip_restriction.virtual_network_subnet_id, null)
      }
    }
    load_balancing_mode              = try(var.site_config.load_balancing_mode, null)
    managed_pipeline_mode            = try(var.site_config.managed_pipeline_mode, null)
    minimum_tls_version              = try(var.site_config.minimum_tls_version, "1.2")
    pre_warmed_instance_count        = try(var.site_config.pre_warmed_instance_count, null)
    remote_debugging_enabled         = try(var.site_config.remote_debugging_enabled, null)
    remote_debugging_version         = try(var.site_config.remote_debugging_version, null)
    runtime_scale_monitoring_enabled = try(var.site_config.runtime_scale_monitoring_enabled, null)

    dynamic "scm_ip_restriction" {
      for_each = toset(try(var.site_config.scm_ip_restriction, null) != null ? ["*"] : [])
      content {
        action = try(var.site_config.scm_ip_restriction.action, null)

        dynamic "headers" {
          for_each = toset(try(var.site_config.scm_ip_restriction.headers, null) != null ? ["*"] : [])
          content {
            x_azure_fdid      = try(var.site_config.scm_ip_restriction.headers.x_azure_fdid, null)
            x_fd_health_probe = try(var.site_config.scm_ip_restriction.headers.x_fd_health_probe, null)
            x_forwarded_for   = try(var.site_config.scm_ip_restriction.headers.x_forwarded_for, null)
            x_forwarded_host  = try(var.site_config.scm_ip_restriction.headers.x_forwarded_host, null)
          }
        }

        ip_address                = try(var.site_config.scm_ip_restriction.ip_address, null)
        name                      = try(var.site_config.scm_ip_restriction.name, null)
        priority                  = try(var.site_config.scm_ip_restriction.priority, null)
        service_tag               = try(var.site_config.scm_ip_restriction.service_tag, null)
        virtual_network_subnet_id = try(var.site_config.scm_ip_restriction.virtual_network_subnet_id, null)
      }
    }

    scm_minimum_tls_version     = try(var.site_config.scm_minimum_tls_version, null)
    scm_use_main_ip_restriction = try(var.site_config.scm_use_main_ip_restriction, null)
    use_32_bit_worker           = try(var.site_config.use_32_bit_worker, null)
    vnet_route_all_enabled      = try(var.site_config.vnet_route_all_enabled, null)
    websockets_enabled          = try(var.site_config.websockets_enabled, null)
    worker_count                = try(var.site_config.worker_count, null)
  }

  app_settings = try(var.app_settings, null)

  dynamic "auth_settings" {
    for_each = toset(try(var.auth_settings, null) != null ? ["*"] : [])
    content {
      enabled = var.auth_settings.enabled

      dynamic "active_directory" {
        for_each = toset(try(var.auth_settings.active_directory, null) != null ? ["*"] : [])
        content {
          client_id                  = var.auth_settings.active_directory.client_id
          allowed_audiences          = try(var.auth_settings.active_directory.allowed_audiences, null)
          client_secret              = try(var.auth_settings.active_directory.client_secret, null)
          client_secret_setting_name = try(var.auth_settings.active_directory.client_secret_setting_name, null)
        }
      }

      additional_login_parameters    = try(var.auth_settings.additional_login_parameters, null)
      allowed_external_redirect_urls = try(var.auth_settings.allowed_external_redirect_urls, null)
      default_provider               = try(var.auth_settings.default_provider, null)

      dynamic "facebook" {
        for_each = toset(try(var.auth_settings.facebook, null) != null ? ["*"] : [])
        content {
          app_id                  = var.auth_settings.facebook.app_id
          app_secret              = try(var.auth_settings.facebook.app_secret, null)
          app_secret_setting_name = try(var.auth_settings.facebook.app_secret_setting_name, null)
          oauth_scopes            = try(var.auth_settings.facebook.oauth_scopes, null)
        }
      }

      dynamic "github" {
        for_each = toset(try(var.auth_settings.github, null) != null ? ["*"] : [])
        content {
          client_id                  = var.auth_settings.github.client_id
          client_secret              = try(var.auth_settings.github.client_secret, null)
          client_secret_setting_name = try(var.auth_settings.github.client_secret_setting_name, null)
          oauth_scopes               = try(var.auth_settings.github.oauth_scopes, null)
        }
      }

      dynamic "google" {
        for_each = toset(try(var.auth_settings.google, null) != null ? ["*"] : [])
        content {
          client_id                  = var.auth_settings.google.client_id
          client_secret              = try(var.auth_settings.google.client_secret, null)
          client_secret_setting_name = try(var.auth_settings.google.client_secret_setting_name, null)
          oauth_scopes               = try(var.auth_settings.google.oauth_scopes, null)
        }
      }

      issuer = try(var.auth_settings.issuer, null)

      dynamic "microsoft" {
        for_each = toset(try(var.auth_settings.microsoft, null) != null ? ["*"] : [])
        content {
          client_id                  = var.auth_settings.microsoft.client_id
          client_secret              = try(var.auth_settings.microsoft.client_secret, null)
          client_secret_setting_name = try(var.auth_settings.microsoft.client_secret_setting_name, null)
          oauth_scopes               = try(var.auth_settings.microsoft.oauth_scopes, null)
        }
      }

      runtime_version               = try(var.auth_settings.runtime_version, null)
      token_refresh_extension_hours = try(var.auth_settings.token_refresh_extension_hours, null)
      token_store_enabled           = try(var.auth_settings.token_store_enabled, null)

      dynamic "twitter" {
        for_each = toset(try(var.auth_settings.twitter, null) != null ? ["*"] : [])
        content {
          consumer_key                 = var.auth_settings.twitter.consumer_key
          consumer_secret              = try(var.auth_settings.twitter.consumer_secret, null)
          consumer_secret_setting_name = try(var.auth_settings.twitter.consumer_secret_setting_name, null)
        }
      }

      unauthenticated_client_action = try(var.auth_settings.unauthenticated_client_action, null)
    }
  }

  dynamic "auth_settings_v2" {
    for_each = toset(try(var.auth_settings_v2, null) != null ? ["*"] : [])
    content {
      auth_enabled                            = try(var.auth_settings_v2.auth_enabled, null)
      runtime_version                         = try(var.auth_settings_v2.runtime_version, null)
      config_file_path                        = try(var.auth_settings_v2.config_file_path, null)
      require_authentication                  = try(var.auth_settings_v2.require_authentication, null)
      unauthenticated_action                  = try(var.auth_settings_v2.unauthenticated_action, null)
      default_provider                        = try(var.auth_settings_v2.default_provider, null)
      excluded_paths                          = try(var.auth_settings_v2.excluded_paths, null)
      require_https                           = try(var.auth_settings_v2.require_https, null)
      http_route_api_prefix                   = try(var.auth_settings_v2.http_route_api_prefix, null)
      forward_proxy_convention                = try(var.auth_settings_v2.forward_proxy_convention, null)
      forward_proxy_custom_host_header_name   = try(var.auth_settings_v2.forward_proxy_custom_host_header_name, null)
      forward_proxy_custom_scheme_header_name = try(var.auth_settings_v2.forward_proxy_custom_scheme_header_name, null)

      dynamic "apple_v2" {
        for_each = toset(try(var.auth_settings_v2.apple_v2, null) != null ? ["*"] : [])
        content {
          client_id                  = var.auth_settings_v2.apple_v2.client_id
          client_secret_setting_name = var.auth_settings_v2.apple_v2.client_secret_setting_name
          login_scopes               = try(var.auth_settings_v2.apple_v2.login_scopes, null)
        }
      }

      dynamic "active_directory_v2" {
        for_each = toset(try(var.auth_settings_v2.active_directory_v2, null) != null ? ["*"] : [])
        content {
          client_id                            = var.auth_settings_v2.active_directory_v2.client_id
          tenant_auth_endpoint                 = var.auth_settings_v2.active_directory_v2.tenant_auth_endpoint
          client_secret_setting_name           = try(var.auth_settings_v2.active_directory_v2.client_secret_setting_name, null)
          client_secret_certificate_thumbprint = try(var.auth_settings_v2.active_directory_v2.client_secret_certificate_thumbprint, null)
          jwt_allowed_groups                   = try(var.auth_settings_v2.active_directory_v2.jwt_allowed_groups, null)
          jwt_allowed_client_applications      = try(var.auth_settings_v2.active_directory_v2.jwt_allowed_client_applications, null)
          www_authentication_disabled          = try(var.auth_settings_v2.active_directory_v2.www_authentication_disabled, null)
          allowed_groups                       = try(var.auth_settings_v2.active_directory_v2.allowed_groups, null)
          allowed_identities                   = try(var.auth_settings_v2.active_directory_v2.allowed_identities, null)
          allowed_applications                 = try(var.auth_settings_v2.active_directory_v2.allowed_applications, null)
          login_parameters                     = try(var.auth_settings_v2.active_directory_v2.login_parameters, null)
          allowed_audiences                    = try(var.auth_settings_v2.active_directory_v2.allowed_audiences, null)
        }
      }

      dynamic "azure_static_web_app_v2" {
        for_each = toset(try(var.auth_settings_v2.azure_static_web_app_v2, null) != null ? ["*"] : [])
        content {
          client_id = var.auth_settings_v2.azure_static_web_app_v2.client_id
        }
      }

      dynamic "custom_oidc_v2" {
        for_each = toset(try(var.auth_settings_v2.custom_oidc_v2, null) != null ? ["*"] : [])
        content {
          name                          = var.auth_settings_v2.custom_oidc_v2.name
          client_id                     = var.auth_settings_v2.custom_oidc_v2.client_id
          openid_configuration_endpoint = var.auth_settings_v2.custom_oidc_v2.openid_configuration_endpoint
          name_claim_type               = try(var.auth_settings_v2.custom_oidc_v2.name_claim_type, null)
          scopes                        = try(var.auth_settings_v2.custom_oidc_v2.scopes, null)
          client_credential_method      = try(var.auth_settings_v2.custom_oidc_v2.client_credential_method, null)
          client_secret_setting_name    = try(var.auth_settings_v2.custom_oidc_v2.client_secret_setting_name, null)
          authorisation_endpoint        = try(var.auth_settings_v2.custom_oidc_v2.authorisation_endpoint, null)
          token_endpoint                = try(var.auth_settings_v2.custom_oidc_v2.token_endpoint, null)
          issuer_endpoint               = try(var.auth_settings_v2.custom_oidc_v2.issuer_endpoint, null)
          certification_uri             = try(var.auth_settings_v2.custom_oidc_v2.certification_uri, null)
        }
      }

      dynamic "facebook_v2" {
        for_each = toset(try(var.auth_settings_v2.facebook_v2, null) != null ? ["*"] : [])
        content {
          app_id                  = var.auth_settings_v2.facebook_v2.app_id
          app_secret_setting_name = var.auth_settings_v2.facebook_v2.app_secret_setting_name
          graph_api_version       = try(var.auth_settings_v2.facebook_v2.graph_api_version, null)
          login_scopes            = try(var.auth_settings_v2.facebook_v2.login_scopes, null)
        }
      }

      dynamic "github_v2" {
        for_each = toset(try(var.auth_settings_v2.github_v2, null) != null ? ["*"] : [])
        content {
          client_id                  = var.auth_settings_v2.github_v2.client_id
          client_secret_setting_name = var.auth_settings_v2.github_v2.client_secret_setting_name
          login_scopes               = try(var.auth_settings_v2.github_v2.login_scopes, null)
        }
      }

      dynamic "google_v2" {
        for_each = toset(try(var.auth_settings_v2.google_v2, null) != null ? ["*"] : [])
        content {
          client_id                  = var.auth_settings_v2.google_v2.client_id
          client_secret_setting_name = var.auth_settings_v2.google_v2.client_secret_setting_name
          allowed_audiences          = try(var.auth_settings_v2.github_v2.allowed_audiences, null)
          login_scopes               = try(var.auth_settings_v2.github_v2.login_scopes, null)
        }
      }

      dynamic "microsoft_v2" {
        for_each = toset(try(var.auth_settings_v2.microsoft_v2, null) != null ? ["*"] : [])
        content {
          client_id                  = var.auth_settings_v2.microsoft_v2.client_id
          client_secret_setting_name = var.auth_settings_v2.microsoft_v2.client_secret_setting_name
          allowed_audiences          = try(var.auth_settings_v2.microsoft_v2.allowed_audiences, null)
          login_scopes               = try(var.auth_settings_v2.microsoft_v2.login_scopes, null)
        }
      }

      dynamic "twitter_v2" {
        for_each = toset(try(var.auth_settings_v2.twitter_v2, null) != null ? ["*"] : [])
        content {
          consumer_key                 = var.auth_settings_v2.twitter_v2.consumer_key
          consumer_secret_setting_name = var.auth_settings_v2.twitter_v2.consumer_secret_setting_name
        }
      }

      dynamic "login" {
        for_each = toset(try(var.auth_settings_v2.login, null) != null ? ["*"] : [])
        content {
          logout_endpoint                   = try(var.auth_settings_v2.login.logout_endpoint, null)
          token_store_enabled               = try(var.auth_settings_v2.login.token_store_enabled, null)
          token_refresh_extension_time      = try(var.auth_settings_v2.login.token_refresh_extension_time, null)
          token_store_path                  = try(var.auth_settings_v2.login.token_store_path, null)
          token_store_sas_setting_name      = try(var.auth_settings_v2.login.token_store_sas_setting_name, null)
          preserve_url_fragments_for_logins = try(var.auth_settings_v2.login.preserve_url_fragments_for_logins, null)
          allowed_external_redirect_urls    = try(var.auth_settings_v2.login.allowed_external_redirect_urls, null)
          cookie_expiration_convention      = try(var.auth_settings_v2.login.cookie_expiration_convention, null)
          cookie_expiration_time            = try(var.auth_settings_v2.login.cookie_expiration_time, null)
          validate_nonce                    = try(var.auth_settings_v2.login.validate_nonce, null)
          nonce_expiration_time             = try(var.auth_settings_v2.login.nonce_expiration_time, null)
        }
      }
    }
  }

  dynamic "backup" {
    for_each = toset(try(var.backup, null) != null ? ["*"] : [])
    content {
      name = var.backup.name
      schedule {
        frequency_interval       = var.backup.schedule.frequency_interval
        frequency_unit           = var.backup.schedule.frequency_unit
        keep_at_least_one_backup = try(var.backup.schedule.keep_at_least_one_backup, null)
        retention_period_days    = try(var.backup.schedule.retention_period_days, null)
        start_time               = try(var.backup.schedule.start_time, null)
      }
      storage_account_url = var.backup.storage_account_url
      enabled             = try(var.backup.enabled, null)
    }
  }

  builtin_logging_enabled            = try(var.builtin_logging_enabled, null)
  client_certificate_enabled         = try(var.client_certificate_enabled, null)
  client_certificate_mode            = try(var.client_certificate_mode, null)
  client_certificate_exclusion_paths = try(var.client_certificate_exclusion_paths, null)

  dynamic "connection_string" {
    for_each = toset(try(var.connection_string, null) != null ? ["*"] : [])
    content {
      name  = var.connection_string.name
      type  = var.connection_string.type
      value = var.connection_string.value
    }
  }

  daily_memory_time_quota      = try(var.daily_memory_time_quota, null)
  enabled                      = try(var.enabled, null)
  content_share_force_disabled = try(var.content_share_force_disabled, null)
  functions_extension_version  = try(var.functions_extension_version, null)
  https_only                   = try(var.https_only, true)

  dynamic "identity" {
    for_each = toset(var.identity != null ? ["*"] : [])
    content {
      type         = var.identity.type
      identity_ids = try(var.identity.identity_ids, null)
    }
  }

  key_vault_reference_identity_id = try(var.key_vault_reference_identity_id, null)

  dynamic "storage_account" {
    for_each = toset(try(var.storage_account, null) != null ? ["*"] : [])
    content {
      access_key   = var.storage_account.access_key
      account_name = var.storage_account.account_name
      name         = var.storage_account.name
      share_name   = var.storage_account.share_name
      type         = var.storage_account.type
      mount_path   = try(var.storage_account.mount_path, null)
    }
  }

  dynamic "sticky_settings" {
    for_each = toset(var.sticky_settings != null ? ["*"] : [])
    content {
      app_setting_names       = try(var.sticky_settings.app_setting_names, null)
      connection_string_names = try(var.sticky_settings.connection_string_names, null)
    }
  }

  storage_account_access_key    = try(var.storage_account_access_key, null)
  storage_account_name          = try(var.storage_account_name, null)
  storage_uses_managed_identity = try(var.storage_uses_managed_identity, null)
  storage_key_vault_secret_id   = try(var.storage_key_vault_secret_id, null)
  zip_deploy_file               = try(var.zip_deploy_file, null)
  tags                          = var.tags
  virtual_network_subnet_id     = var.virtual_network_subnet_id

  dynamic "timeouts" {
    for_each = toset(try(var.timeouts, null) != null ? ["*"] : [])
    content {
      create = try(var.timeouts.create, null)
      update = try(var.timeouts.update, null)
      read   = try(var.timeouts.read, null)
      delete = try(var.timeouts.delete, null)
    }
  }

  lifecycle {
    ignore_changes = [
      ###################################################
      # Ignoring changes to backup, connection_string, app setting
      # application_insights_connection_string, application_insights_key,
      # and "hidden-link" tags because they contain sensitive data. 
      # App settings is managed by the AppDev Team. 
      ###################################################
      app_settings, auth_settings_v2, storage_account_access_key, backup[0].storage_account_url, connection_string, site_config[0].application_insights_connection_string,
      site_config[0].application_insights_key, tags["hidden-link: /app-insights-conn-string"], tags["hidden-link: /app-insights-instrumentation-key"],
      sticky_settings, site_config[0].ip_restriction_default_action, site_config[0].scm_ip_restriction_default_action, site_config[0].health_check_path,
      site_config[0].health_check_eviction_time_in_min
    ]
  }
}
