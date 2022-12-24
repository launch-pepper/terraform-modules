output "ingress_ip" {
  sensitive   = false
  value       = data.kubernetes_service.ingress-controller.status[0].load_balancer[0].ingress[0].ip
  description = "IP address of the OpenStack LoadBalancer created by the installation of the ingress controller"
}