resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
    # annotations = {
    #   "linkerd.io/inject" = "enabled"
    # }
  }

}

resource "helm_release" "kube-prometheus-stack" {
  name       = "kube-prometheus-stack"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.kube_prometheus_stack_version
}
