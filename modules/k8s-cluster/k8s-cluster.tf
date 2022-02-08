resource "azurerm_resource_group" "GitHubActionRunners_rg" {
  name     = var.resource_group
  location = var.location
}

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "monitoring" {
  # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
  name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location            = var.location
  resource_group_name = azurerm_resource_group.GitHubActionRunners_rg.name
  sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "monitoring" {
  solution_name         = var.azure_log_analytics_solution_name
  location              = azurerm_log_analytics_workspace.monitoring.location
  resource_group_name   = azurerm_resource_group.GitHubActionRunners_rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.monitoring.id
  workspace_name        = azurerm_log_analytics_workspace.monitoring.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "GitHubActionRunners_k8s_cluster" {
  name                = var.runner_cluster_name
  location            = azurerm_resource_group.GitHubActionRunners_rg.location
  resource_group_name = azurerm_resource_group.GitHubActionRunners_rg.name
  dns_prefix          = azurerm_resource_group.GitHubActionRunners_rg.name
  kubernetes_version  = var.runner_kubernetes_version

  default_node_pool {
    name            = var.runner_default_node_pool_name
    node_count      = var.runner_default_node_pool_node_count
    vm_size         = var.runner_default_vm_size
    type            = var.runner_default_node_pool_type
    os_disk_size_gb = var.runner_default_node_pool_os_disk_size_gb
  }

  service_principal {
    client_id     = var.serviceprinciple_id
    client_secret = var.serviceprinciple_key
  }

  linux_profile {
    admin_username = var.runner_k8s_linux_profile_admin_username
    ssh_key {
      key_data = var.ssh_key
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "Standard"
  }

  addon_profile {
    oms_agent {
      enabled                    = var.addon_profile_oms_agent_enabled
      log_analytics_workspace_id = azurerm_log_analytics_workspace.monitoring.id
    }
  }

}

/*
resource "azurerm_kubernetes_cluster_node_pool" "monitoring" {
  name                  = "monitoring"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-testing.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1
  os_disk_size_gb       = 250
  os_type               = "Linux"
}

*/
