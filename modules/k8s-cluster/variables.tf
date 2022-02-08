variable "serviceprinciple_id" {
}

variable "serviceprinciple_key" {
}

variable "location" {
}

variable "runner_kubernetes_version" {
  type    = string
  default = "1.22.4"
}

variable "ssh_key" {
}

variable "resource_group" {
}

variable "runner_cluster_name" {
}

variable "subscription_id" {
}

variable "tenant_id" {
}

variable "runner_default_vm_size" {
  type    = string
  default = "Standard_D2as_v5"
}

variable "runner_default_node_pool_name" {
  type    = string
  default = "default"
}

variable "runner_default_node_pool_node_count" {
  type    = number
  default = 1
}
variable "runner_default_node_pool_type" {
  type    = string
  default = "VirtualMachineScaleSets"
}

variable "runner_default_node_pool_os_disk_size_gb" {
  type    = number
  default = 30
}

variable "runner_k8s_linux_profile_admin_username" {
  type    = string
  default = "azureuser"
}

variable "addon_profile_oms_agent_enabled" {
  type    = bool
  default = true
}

variable "addon_profile_kube_dashboard_enabled" {
  type    = bool
  default = true
}

variable "azure_log_analytics_solution_name" {
  type    = string
  default = "ContainerInsights"
}
variable "log_analytics_workspace_name" {
  default = "actionRunnerAnalyticsWorkspace"
}

variable "log_analytics_workspace_sku" {
  default = "PerGB2018"
}
