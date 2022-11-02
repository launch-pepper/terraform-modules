# cert-manager

terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "~> 2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2"
    }
  }
}

resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
    annotations = {
      "linkerd.io/inject" = "enabled"
    }
  }
}

resource "helm_release" "cert-manager" {
  name       = "cert-manager-jetstack"
  namespace  = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.cert_manager_version
  set {
    name  = "installCRDs"
    value = var.install_crds
  }
}