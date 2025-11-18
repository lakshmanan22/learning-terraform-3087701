variable "name" {
  description = "The name of the Web App."
  type        = string
}

variable "environment" {
  description = "The name of the environment (dev, test, prod, dr-prod)"
  type        = string
}

variable "app_role_assignments" {
  description = "Role assignments for the web app"
  type        = any
}

variable "private_endpoint_subnet_id" {
  description = "The subnet id of the private endpoint."
}

variable "diagnostics_enabled" {
  description = "Whether to enabled diagnostic settings for the Keyvault."
  type        = bool
}

variable "diagnostics_name" {
  description = "The name of the diagnosic settings."
}
variable "log_analytics_workspace_id" {
  description = "The id of the log analytics workspace for diagnostic settings."
}

variable "resource_group_name" {
  description = "The resource group of the Web app."
}

variable "location" {
  description = "The location of the web app"
}

variable "app_service_plan_id" {
  type        = string
  description = "(Required) The ID of the App Service Plan within which to create this Web App."
}

variable "virtual_network_subnet_id" {
  type        = string
  description = "(Optional) The subnet id which will be used by this Web App for regional virtual network integration."
}

variable "identity" {
  type        = any
  description = "(Optional) A identity block."
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
}

variable "network_tags" {
  type        = map(string)
  description = "The tags for the Network Resource Group"
}
