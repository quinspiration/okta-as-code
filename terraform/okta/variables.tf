variable "okta_org_name" {
  description = "Okta org subdomain, without .okta.com"
  type        = string
}

variable "okta_base_url" {
  description = "Okta base URL, okta.com for Integrator Free Plan orgs"
  type        = string
  default     = "okta.com"
}

variable "departments" {
  description = "Department groups to create, keyed by group name"
  type        = map(string)

  default = {
    Engineering = "Engineering staff"
    Sales       = "Sales staff"
    Clinical    = "Clinical staff"
    Contractors = "External contractors"
  }
}