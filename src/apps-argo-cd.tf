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
  version    = "4.9.8"
}

resource "kubernetes_secret" "personal_apps_gitops_repo" {
  metadata {
    name      = "personal-apps-gitops-repo"
    namespace = kubernetes_namespace.argo_cd.metadata.0.name

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
      environment                      = terraform.workspace
    }
  }

  data = {
    type = "git"
    url  = "https://github.com/Harmelodic/personal-apps-gitops.git"
  }
}
