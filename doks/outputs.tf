output "kube_endpoint" {
  sensitive   = false
  value       = digitalocean_kubernetes_cluster.cluster.endpoint
  description = "Kubernetes API server endpoint"
}

output "kube_token" {
  sensitive   = true
  value       = digitalocean_kubernetes_cluster.cluster.kube_config[0].token
  description = "Kubernetes cluster administrator token"
}

output "kube_ca_certificate" {
  sensitive   = true
  value       = digitalocean_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate
  description = "Validate authenticity of the API endpoint"
}

output "pod_network" {
  sensitive = false
  value     = digitalocean_kubernetes_cluster.cluster.cluster_subnet
}

output "service_network" {
  sensitive = false
  value     = digitalocean_kubernetes_cluster.cluster.service_subnet
}

output "node_network" {
  sensitive = false
  value     = digitalocean_vpc.vpc.ip_range
}