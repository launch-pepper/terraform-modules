# `doks` terraform module

This Terraform module makes it easy to provision a Kubernetes cluster using DOKS from Digital Ocean.

## Input Variables

- `name` (string) - Cluster name
- `version` - Kubernetes version
availability-matrix/)
- `default_node_pool` (object ```{name: string, size: string, node_count: int}```) - Definition of default node pool, which is required for a DOKS cluster
- `region` (string) - [Digital Ocean region](https://docs.digitalocean.com/products/platform/)

## Usage

```hcl
module "cluster" {
  name              = "Cluster Name"
  version           = "1.21."
  default_node_pool = {
    name       = "default"
    size       = "s-2vcpu-4gb"
    node_count = 3
  }
  region            = "sfo3"
}
```

## Outputs

