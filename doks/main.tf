terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_vpc" "vpc" {
  name   = var.name
  region = var.region
}

data "digitalocean_kubernetes_versions" "versions" {
  version_prefix = var.kube_version
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  name     = var.name
  region   = var.region
  version  = data.digitalocean_kubernetes_versions.versions.latest_version
  vpc_uuid = digitalocean_vpc.vpc.id
  node_pool {
    name       = var.default_node_pool.name
    size       = var.default_node_pool.size
    node_count = var.default_node_pool.node_count
  }
}