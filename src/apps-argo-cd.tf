resource "kubernetes_namespace" "argo_cd" {
  metadata {
    name = "argo-cd"

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
  version    = "4.9.8"
}

resource "kubernetes_secret" "example_apps_repo" {
  metadata {
    name      = "example-apps-repo"
    namespace = kubernetes_namespace.argo_cd.metadata.0.name

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
      environment                      = terraform.workspace
    }
  }

  data = {
    type = "git"
    url  = "https://github.com/argoproj/argocd-example-apps.git"
  }
}
