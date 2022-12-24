locals {
  external_dns = {
    provider = "cloudflare"
    cloudflare = {
      proxied  = false
      apiToken = var.cloudflare_api_token
    }
    crd = {
      create = true
    }
    triggerLoopOnEvent = true
    interval           = "10m"
    policy             = "sync"
  }
}

resource "kubernetes_namespace" "external-dns" {
  metadata {
    name = "external-dns"
    annotations = {
      "linkerd.io/inject" = "enabled"
    }
  }
}

resource "helm_release" "external-dns" {
  name       = "external-dns"
  namespace  = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = var.external_dns_version
  values = [
    yamlencode(local.external_dns)
  ]
}