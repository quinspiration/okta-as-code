resource "okta_group" "departments" {
  for_each = var.departments

  name        = each.key
  description = each.value
}