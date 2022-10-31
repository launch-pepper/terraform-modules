variable "linkerd_cni_version" {
  type = string
  default = ""
}

variable "linkerd_crds_version" {
  type = string
  default = ""
}

variable "linkerd_control_plane_version" {
  type = string
  default = ""
}

variable "linkerd_k8s_namespace" {
  type = string
  default = "linkerd"
}