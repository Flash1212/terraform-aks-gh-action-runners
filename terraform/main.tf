module "cluster" {
  source               = "./modules/cluster/"
  cluster_name         = var.cluster_name
  resource_group       = var.resource_group
  serviceprinciple_id  = var.serviceprinciple_id
  serviceprinciple_key = var.serviceprinciple_key
  ssh_key              = var.ssh_key
  location             = var.location
  kubernetes_version   = var.kubernetes_version
  subscription_id      = var.subscription_id
  tenant_id            = var.tenant_id
}

module "k8s" {
  source                 = "./modules/k8s/"
  host                   = module.cluster.host
  client_certificate     = base64decode(module.cluster.client_certificate)
  client_key             = base64decode(module.cluster.client_key)
  cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate)
}