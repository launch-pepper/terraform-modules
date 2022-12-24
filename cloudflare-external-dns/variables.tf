variable "cloudflare_api_token" {
  type        = string
  sensitive   = true
  description = "Cloudflare API token to use for bootstrapping External-DNS"
}

variable "external_dns_version" {
  type = string
  default = "" 
}