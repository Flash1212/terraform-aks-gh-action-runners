variable "serviceprinciple_id" {
}

variable "serviceprinciple_key" {
}

variable "location" {
}

variable "kubernetes_version" {
  type    = string
  default = "1.22.4"
}

variable "ssh_key" {
}

variable "resource_group" {
}

variable "cluster_name" {
}

variable "subscription_id" {
}

variable "tenant_id" {
}

variable "vm_size" {
  type    = string
  default = "Standard_D2as_v5"
}
