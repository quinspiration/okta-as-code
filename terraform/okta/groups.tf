resource "okta_group" "departments" {
  for_each = var.departments

  name        = each.key
  description = each.value
}

resource "okta_group" "ca_test_users" {
  name        = "CA Test Users"
  description = "Test users based in CA"
}