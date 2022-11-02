# Linkerd Service Mesh

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

resource "kubernetes_namespace" "linkerd" {
  metadata {
    name = var.linkerd_k8s_namespace
  }
}

# Install Linkerd Container Network Interface (CNI) Plugin
# https://linkerd.io/2.12/features/cni/#using-helm

resource "helm_release" "linkerd2-cni" {
  name       = "linkerd2-cni"
  namespace = var.linkerd_k8s_namespace
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd2-cni"
  version    = var.linkerd_cni_version
}

# Install Linkerd CRDs and Control Plane
# https://linkerd.io/2.12/tasks/install-helm/#helm-install-procedure

resource "helm_release" "linkerd-crds" {
  depends_on = [
    helm_release.linkerd2-cni
  ]
  name       = "linkerd-crds"
  namespace = var.linkerd_k8s_namespace
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd-crds"
  version    = var.linkerd_crds_version

  set {
    name  = "cniEnabled"
    value = true
  }

}

resource "helm_release" "linkerd-control-plane" {
  depends_on = [
    helm_release.linkerd2-cni,
    helm_release.linkerd-crds
  ]
  name       = "linkerd-control-plane"
  namespace = var.linkerd_k8s_namespace
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd-control-plane"
  version    = var.linkerd_control_plane_version

  set {
    name  = "ha"
    value = true
  }
  set {
    name  = "cniEnabled"
    value = true
  }
  set {
    name  = "identityTrustAnchorsPEM"
    value = var.mtls_root_ca_cert
  }
  set {
    name  = "identity.issuer.tls.crtPEM"
    value = var.mtls_intermediate_ca_cert
  }
  set {
    name  = "identity.issuer.tls.keyPEM"
    value = var.mtls_intermediate_ca_private_key
  }
  set {
    name  = "identity.issuer.crtExpiry"
    value = var.mtls_cert_expiry
  }
}