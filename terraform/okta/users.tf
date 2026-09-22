resource "okta_user" "eng_test_user" {
  first_name = "Engineering"
  last_name  = "Test"
  login      = "eng-test-user@quinspo.com"
  email      = "eng-test-user@quinspo.com"
  department = "Engineering"
  state      = "CA"
}

resource "okta_user" "sales_test_user" {
  first_name = "Sales"
  last_name  = "Test"
  login      = "sales-test-user@quinspo.com"
  email      = "sales-test-user@quinspo.com"
  department = "Sales"
  state      = "CA"
}

resource "okta_user" "clinical_test_user" {
  first_name = "Clinical"
  last_name  = "Test"
  login      = "clinical-test-user@quinspo.com"
  email      = "clinical-test-user@quinspo.com"
  department = "Clinical"
}

resource "okta_user" "contractor_test_user" {
  first_name = "Contractor"
  last_name  = "Test"
  login      = "contractor-test-user@quinspo.com"
  email      = "contractor-test-user@quinspo.com"
  department = "Contractors"
}