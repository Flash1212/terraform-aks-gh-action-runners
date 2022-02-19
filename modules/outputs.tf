output "resource_group_name" {
  value = azurerm_resource_group.GitHubActionRunners_rg.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.GitHubActionRunners_k8s_cluster.name
}
