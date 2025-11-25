locals {

}

#-------------------------------------------
# CDN Endpoint
#-------------------------------------------
resource "azurerm_cdn_endpoint" "this" {
  name                   = var.name                //"cdne${local.lower_cpc}dt${lower(var.cdn_configuration.application_two_letter_abbrevation == null ? var.application_abbrevation : var.cdn_configuration.application_two_letter_abbrevation)}${lower(var.environment)}"
  resource_group_name    = var.resource_group_name //"rgAM-DT-Integration-${title(var.environment)}"
  location               = "global"
  profile_name           = var.profile_name //"cdnpCPC${local.location_abbrev}-DT-${title(var.environment)}"
  origin_path            = var.origin_path  #"${var.storage_container_name}"
  is_compression_enabled = true
  origin_host_header     = var.origin_host_header //"sastdcpc${local.location_abbrev}dtcdn${lower(var.environment)}.blob.core.windows.net"
  origin {
    name      = var.origin.name      //"sastdcpc${local.location_abbrev}dtcdn${lower(var.environment)}-blob-core-windows-net"
    host_name = var.origin.host_name //"sastdcpc${local.location_abbrev}dtcdn${lower(var.environment)}.blob.core.windows.net"
  }
  tags = {
    "CostCenter"  = "P3601"
    "Department"  = "Digital Transform"
    "Description" = "Digital Transformation HUB Resources"
    "ManagedBy"   = "DT"
  }
  optimization_type = "GeneralWebDelivery"
  content_types_to_compress = [
    "application/eot",
    "application/font",
    "application/font-sfnt",
    "application/javascript",
    "application/json",
    "application/opentype",
    "application/otf",
    "application/pkcs7-mime",
    "application/truetype",
    "application/ttf",
    "application/vnd.ms-fontobject",
    "application/x-font-opentype",
    "application/x-font-truetype",
    "application/x-font-ttf",
    "application/x-httpd-cgi",
    "application/x-javascript",
    "application/x-mpegurl",
    "application/x-opentype",
    "application/x-otf",
    "application/x-perl",
    "application/x-ttf",
    "application/xhtml+xml",
    "application/xml",
    "application/xml+rss",
    "font/eot",
    "font/opentype",
    "font/otf",
    "font/ttf",
    "image/svg+xml",
    "text/css",
    "text/csv",
    "text/html",
    "text/javascript",
    "text/js",
    "text/plain",
    "text/richtext",
    "text/tab-separated-values",
    "text/x-component",
    "text/x-java-source",
    "text/x-script",
    "text/xml",
  ]
  geo_filter {
    action = "Block"
    country_codes = [
      "IR",
      "IQ",
      "KP",
      "RO",
      "RU",
      "UA"
    ]
    relative_path = "/"
  }
  global_delivery_rule {
    cache_expiration_action {
      behavior = "Override"
      duration = "365.00:00:00"
    }
  }
  delivery_rule {
    name  = "EnforceHTTPS"
    order = 1
    request_scheme_condition {
      match_values = [
        "HTTP",
      ]
      negate_condition = false
      operator         = "Equal"
    }
    url_redirect_action {
      protocol      = "Https"
      redirect_type = "Found"
    }
  }
  delivery_rule {
    name  = "SinglePageApp"
    order = 2
    cache_expiration_action {
      behavior = "Override"
      duration = "00:05:00"
    }
    url_path_condition {
      match_values = [
        "/assets/",
      ]
      negate_condition = true
      operator         = "Contains"
      transforms       = []
    }
    url_rewrite_action {
      destination             = "/index.html"
      preserve_unmatched_path = false
      source_pattern          = "/"
    }
  }
  delivery_rule {
    name  = "Assets"
    order = 3
    modify_response_header_action {
      action = "Append"
      name   = "Cache-Control"
      value  = ", immutable"
    }
    url_path_condition {
      match_values = [
        "/assets/",
      ]
      negate_condition = false
      operator         = "Contains"
      transforms       = []
    }
  }
  delivery_rule {
    name  = "OtherThingsThatChange"
    order = 4
    cache_expiration_action {
      behavior = "Override"
      duration = "00:05:00"
    }
    url_path_condition {
      match_values = [
        "/manifest.json",
      ]
      negate_condition = false
      operator         = "Equal"
      transforms       = []
    }
  }
  delivery_rule {
    name  = "SecurityHeaders"
    order = 5
    modify_response_header_action {
      action = "Overwrite"
      name   = "X-Content-Type-Options"
      value  = "nosniff"
    }
    modify_response_header_action {
      action = "Overwrite"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000"
    }
    modify_response_header_action {
      action = "Overwrite"
      name   = "X-Frame-Options"
      value  = "SAMEORIGIN"
    }
    modify_response_header_action {
      action = "Overwrite"
      name   = "Content-Security-Policy"
      value  = "default-src 'self' 'unsafe-inline' https://login.microsoftonline.com https://cdn.intake-lr.com https://r.intake-lr.com https://cdn.ingest-lr.com https://r.ingest-lr.com https://app.launchdarkly.com https://clientstream.launchdarkly.com https://events.launchdarkly.com https://southcentralus-3.in.applicationinsights.azure.com https://graph.microsoft.com https://dc.services.visualstudio.com https://api-dev.cpchem.com; worker-src 'self' data: blob:; img-src 'self' data:; frame-ancestors 'self'"
    }
    request_uri_condition {
      match_values     = null
      negate_condition = false
      operator         = "Any"
      transforms       = []
    }
  }
  delivery_rule {
    name  = "UselessHeaders"
    order = 6
    modify_response_header_action {
      action = "Delete"
      name   = "Server"
    }
    modify_response_header_action {
      action = "Delete"
      name   = "x-ms-blob-type"
    }
    modify_response_header_action {
      action = "Delete"
      name   = "x-ms-lease-status"
    }
    modify_response_header_action {
      action = "Delete"
      name   = "x-ms-request-id"
    }
    modify_response_header_action {
      action = "Delete"
      name   = "x-ms-version"
    }
    request_uri_condition {
      match_values     = null
      negate_condition = false
      operator         = "Any"
      transforms       = []
    }
  }
  delivery_rule {
    name  = "ContentSecurityPolicy"
    order = 7
    modify_response_header_action {
      action = "Delete"
      name   = "Content-Security-Policy"
    }
    url_file_extension_condition {
      match_values = [
        "css",
        "jpeg",
        "jpg",
        "png",
      ]
      negate_condition = false
      operator         = "EndsWith"
      transforms = [
        "Lowercase",
      ]
    }
  }
  lifecycle {
    ignore_changes = [delivery_rule]
  }
}

#-------------------------------------------
# CDN Endpoint Custom Domain
#-------------------------------------------
resource "azurerm_cdn_endpoint_custom_domain" "this" {
  count = var.custom_domain_hostname != null ? 1 : 0

  cdn_endpoint_id = azurerm_cdn_endpoint.this.id
  host_name       = var.custom_domain_hostname
  name            = var.custom_domain_name

  dynamic "cdn_managed_https" {
    for_each = var.cdn_managed_https_enabled ? [1] : []
    content {
      certificate_type = "Dedicated"
      protocol_type    = "ServerNameIndication"
      tls_version      = "TLS12"
    }
  }
}

#--------------------------------------------------------------------
#  MODULE IMPLEMENTATION- CDN Storage Account Role Assignment
#--------------------------------------------------------------------
module "cdn_storage_account_role_assignments" {
  source  = "app.terraform.io/cpchem/cpc-base-role-assignment/azurerm"
  version = "0.1.5"

  for_each = { for i, obj in var.cdn_storage_account_role_assignments : i => obj }

  scope                = "/subscriptions/9afa9e1f-5273-4c90-888e-8164a9c052e3/resourceGroups/rgAM-DT-Integration-${title(var.environment)}/providers/Microsoft.Storage/storageAccounts/sastdcpcscusdtcdn${lower(var.environment)}"
  principal_id         = each.value["principal_id"]
  role_definition_name = each.value["role_definition_name"]
}

#-------------------------------------------
# CDN Storage Container
#-------------------------------------------
resource "azurerm_storage_container" "this" {

  count = var.cdn_storage_container_name != null ? 1 : 0

  name                  = var.cdn_storage_container_name
  storage_account_name  = var.cdn_storage_account_name
  container_access_type = "blob"

}

#-------------------------------------------
# CDN Storage Blob
#-------------------------------------------
resource "azurerm_storage_blob" "this" {

  count = var.cdn_storage_container_name != null ? 1 : 0

  name                   = "index.html"
  storage_account_name   = var.cdn_storage_account_name
  storage_container_name = azurerm_storage_container.this[0].name
  type                   = "Block"
  source                 = "${path.module}/index.html"
  content_type           = "text/html"

  lifecycle {
    ignore_changes = [content_type, content_md5, access_tier, source, cache_control, parallelism, size]
  }
}

#-----------------------------------------------------------
#  MODULE IMPLEMENTATION- CDN Endpoint Group Role Assignment
#-----------------------------------------------------------
module "cdn_endpoint_role_assignments" {
  source  = "app.terraform.io/cpchem/cpc-base-role-assignment/azurerm"
  version = "0.1.5"

  for_each = { for i, obj in var.endpoint_role_assignments : i => obj }

  scope                = azurerm_cdn_endpoint.this.id
  principal_id         = each.value["principal_id"]
  role_definition_name = each.value["role_definition_name"]

}

#--------------------------------------------------------------------
#  MODULE IMPLEMENTATION- CDN Storage Container Group Role Assignment
#--------------------------------------------------------------------
module "cdn_storage_container_group_role_assignments" {
  source  = "app.terraform.io/cpchem/cpc-base-role-assignment/azurerm"
  version = "0.1.5"

  for_each = var.cdn_storage_container_name != null ? { for i, obj in var.cdn_storage_container_role_assignments : i => obj } : {}

  scope                = azurerm_storage_container.this[0].resource_manager_id
  principal_id         = each.value["principal_id"]
  role_definition_name = each.value["role_definition_name"]
  principal_type       = try(each.value["principal_type"], null)
  display_name         = try(each.value["display_name"], null)
}
