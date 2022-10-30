terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2"
    }
  }
}

resource "tls_private_key" "mtls-root-ca" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_self_signed_cert" "mtls-root-ca" {
  is_ca_certificate = true
  private_key_pem   = tls_private_key.mtls-root-ca.private_key_pem
  subject {
    common_name = "root.linkerd.cluster.local"
  }
  dns_names = ["root.linkerd.cluster.local"]
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
    "cert_signing"
  ]
  validity_period_hours = 87600
}

resource "tls_private_key" "mtls-intermediate-ca" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_cert_request" "mtls-intermediate-ca" {
  private_key_pem = tls_private_key.mtls-intermediate-ca.private_key_pem
  subject {
    common_name = "identity.linkerd.cluster.local"
  }
  dns_names = ["identity.linkerd.cluster.local"]
}

resource "tls_locally_signed_cert" "mtls-intermediate-ca" {
  is_ca_certificate  = true
  cert_request_pem   = tls_cert_request.mtls-intermediate-ca.cert_request_pem
  ca_private_key_pem = tls_private_key.mtls-root-ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.mtls-root-ca.cert_pem
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
    "cert_signing"
  ]
  validity_period_hours = 8760
}

resource "helm_release" "linkerd2-cni" {
  name       = "linkerd2-cni"
  namespace = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd2-cni"
  version    = var.linkerd2_cni_version
}

resource "helm_release" "linkerd-crds" {
  depends_on = [
    helm_release.linkerd2-cni
  ]
  name       = "linkerd-crds"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd-crds"
  version    = var.linkerd2_version

  set {
    name  = "cniEnabled"
    value = true
  }
  set {
    name  = "identityTrustAnchorsPEM"
    value = tls_self_signed_cert.mtls-root-ca.cert_pem
  }
  set {
    name  = "identity.issuer.tls.crtPEM"
    value = tls_locally_signed_cert.mtls-intermediate-ca.cert_pem
  }
  set {
    name  = "identity.issuer.tls.keyPEM"
    value = tls_private_key.mtls-intermediate-ca.private_key_pem
  }
  set {
    name  = "identity.issuer.crtExpiry"
    value = tls_locally_signed_cert.mtls-intermediate-ca.validity_end_time
  }
}

resource "helm_release" "linkerd-control-plane" {
  depends_on = [
    helm_release.linkerd2
  ]
  name       = "linkerd-control-plane"
  namespace = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd-control-plane"
  version    = var.linkerd2_control_plane_version

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
    value = tls_self_signed_cert.mtls-root-ca.cert_pem
  }
  set {
    name  = "identity.issuer.tls.crtPEM"
    value = tls_locally_signed_cert.mtls-intermediate-ca.cert_pem
  }
  set {
    name  = "identity.issuer.tls.keyPEM"
    value = tls_private_key.mtls-intermediate-ca.private_key_pem
  }
  set {
    name  = "identity.issuer.crtExpiry"
    value = tls_locally_signed_cert.mtls-intermediate-ca.validity_end_time
  }
}