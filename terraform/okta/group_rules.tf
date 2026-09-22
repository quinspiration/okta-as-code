resource "okta_group_rule" "eng_dept_group_rule" {
  name              = "Assign Engineering Dept Group"
  status            = "ACTIVE"
  group_assignments = [okta_group.departments["Engineering"].id]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department == \"Engineering\""
}

resource "okta_group_rule" "clinical_dept_group_rule" {
  name              = "Assign Clinical Dept Group"
  status            = "ACTIVE"
  group_assignments = [okta_group.departments["Clinical"].id]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department == \"Clinical\""
}

resource "okta_group_rule" "sales_dept_group_rule" {
  name              = "Assign Sales Dept Group"
  status            = "ACTIVE"
  group_assignments = [okta_group.departments["Sales"].id]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department == \"Sales\""
}

resource "okta_group_rule" "contractor_dept_group_rule" {
  name              = "Assign Contractor Dept Group"
  status            = "ACTIVE"
  group_assignments = [okta_group.departments["Contractors"].id]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department == \"Contractors\""
}

resource "okta_group_rule" "ca_test_users_group_rule" {
  name              = "Assign CA Test Users Group"
  status            = "ACTIVE"
  group_assignments = [okta_group.ca_test_users.id]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "String.stringContains(user.login, 'test') && user.state == 'CA'"
}