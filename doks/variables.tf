variable "name" {
  type    = string
  default = "test"
}

variable "kube_version" {
  type    = string
  default = "1.24."
}

variable "default_node_pool" {
  type = object({
    name       = string
    size       = string
    node_count = number
  })
  default = {
    name       = "default"
    size       = "s-2vcpu-4gb"
    node_count = 3
  }
}

variable "region" {
  type    = string
  default = "sfo3"
}