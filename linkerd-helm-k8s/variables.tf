variable "linkerd_cni_version" {
  type    = string
  default = ""
}

variable "linkerd_crds_version" {
  type    = string
  default = ""
}

variable "linkerd_control_plane_version" {
  type    = string
  default = ""
}

variable "linkerd_k8s_namespace" {
  type    = string
  default = "linkerd"
}

variable "mtls_root_ca_cert" {
  type = string
}

variable "mtls_intermediate_ca_cert" {
  type = string
}

variable "mtls_intermediate_ca_private_key" {
  type = string
}

variable "mtls_cert_expiry" {
  type = string
}
