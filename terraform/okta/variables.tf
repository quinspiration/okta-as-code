variable "okta_org_name" {
  description = "Okta org subdomain, without .okta.com"
  type        = string
}

variable "okta_base_url" {
  description = "Okta base URL, okta.com for Integrator Free Plan orgs"
  type        = string
  default     = "okta.com"
}