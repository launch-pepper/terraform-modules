## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.linkerd-control-plane](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.linkerd-crds](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.linkerd2-cni](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.linkerd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_linkerd_cni_version"></a> [linkerd\_cni\_version](#input\_linkerd\_cni\_version) | n/a | `string` | `""` | no |
| <a name="input_linkerd_control_plane_version"></a> [linkerd\_control\_plane\_version](#input\_linkerd\_control\_plane\_version) | n/a | `string` | `""` | no |
| <a name="input_linkerd_crds_version"></a> [linkerd\_crds\_version](#input\_linkerd\_crds\_version) | n/a | `string` | `""` | no |
| <a name="input_linkerd_k8s_namespace"></a> [linkerd\_k8s\_namespace](#input\_linkerd\_k8s\_namespace) | n/a | `string` | `"linkerd"` | no |
| <a name="input_mtls_cert_expiry"></a> [mtls\_cert\_expiry](#input\_mtls\_cert\_expiry) | n/a | `string` | n/a | yes |
| <a name="input_mtls_intermediate_ca_cert"></a> [mtls\_intermediate\_ca\_cert](#input\_mtls\_intermediate\_ca\_cert) | n/a | `string` | n/a | yes |
| <a name="input_mtls_intermediate_ca_private_key"></a> [mtls\_intermediate\_ca\_private\_key](#input\_mtls\_intermediate\_ca\_private\_key) | n/a | `string` | n/a | yes |
| <a name="input_mtls_root_ca_cert"></a> [mtls\_root\_ca\_cert](#input\_mtls\_root\_ca\_cert) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
