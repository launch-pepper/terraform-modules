resource "kubernetes_namespace" "ingress-controller" {
  metadata {
    name = "ingress-controller"
  }
}

resource "helm_release" "ingress-controller" {
  name       = "ingress-nginx"
  namespace  = "ingress-controller"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  version    = var.nginx_ingress_version
  set {
    name  = "controller.podAnnotations.linkerd\\.io\\/inject"
    value = "enabled"
  }
}

data "kubernetes_service" "ingress-controller" {
  depends_on = [
    helm_release.ingress-controller
  ]
  metadata {
    name      = "ingress-nginx-nginx-ingress"
    namespace = "ingress-controller"
  }
}