resource "kubernetes_namespace" "argo_cd" {
  metadata {
    name = "argocd"

    labels = {
      environment = terraform.workspace
    }
  }
}

resource "helm_release" "argo_cd" {
  chart      = "argo-cd"
  name       = "argo-cd"
  namespace  = kubernetes_namespace.argo_cd.metadata.0.name
  repository = "https://argoproj.github.io/argo-helm"
  version    = "4.9.10"
}

resource "kubernetes_manifest" "apps_gitops_argo_app" {
  manifest = yamldecode(file("./apps-argo-cd-gitops-app.yaml"))
}
