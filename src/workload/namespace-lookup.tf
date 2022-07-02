variable "namespace" {
  description = "Kubernetes namespace for the workload's Kubernetes Service Account"
  type = string
}

data "kubernetes_namespace" "target" {
  metadata {
    name = var.namespace
  }
}
