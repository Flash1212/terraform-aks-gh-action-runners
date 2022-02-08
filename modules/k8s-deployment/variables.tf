variable "host" {
}

variable "client_certificate" {
}

variable "client_key" {
}

variable "cluster_ca_certificate" {
}

variable "metadata_name" {
  type    = string
  default = "github-actions-k8s"
}

variable "metadata_labels" {
  description = "List of maps containing labels for k8s deployment object"
  type        = map(string)
  default = {
    environment = "dev"
    track       = "daily"
    app         = "github-actions-runners"
  }
}

variable "label_match" {
  description = "Label to match for deployment"
  type        = map(string)
  default = {
    app = "github-actions-runners"
  }
}
