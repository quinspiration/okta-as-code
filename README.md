# okta-as-code

Managing an Okta tenant with Terraform. Groups, users, and group rules are declared in code and changed through Git instead of the admin console.

This is a personal project built against my own Okta Integrator Free Plan org. It is not production, and it is a work in progress.

## Why

I've spent years configuring Okta by hand: groups, rules, SSO apps, policies. The console gives you no record of why something changed and no way to review a change before it goes live. This repo is me working through what it looks like to treat identity configuration like infrastructure instead.

## What's here so far

- **Department groups** created from a single map variable with `for_each`
- **Test users** with a `department` attribute set, used as fixtures for the rules
- **Group rules** that assign users to their department group based on that attribute, plus one rule that has nothing to do with departments

## Layout

```
terraform/
  okta/
    versions.tf                 provider and version constraints
    variables.tf                inputs
    groups.tf                   department groups
    users.tf                    test fixtures
    group_rules.tf              assignment rules
    terraform.tfvars.example    copy to terraform.tfvars and fill in
```

## Running it

You need an Okta org and an API token for it.

```bash
export OKTA_API_TOKEN="your-token"
cd terraform/okta
cp terraform.tfvars.example terraform.tfvars   # set your org name
terraform init
terraform plan
terraform apply
```

The token comes from the environment and is never written to a file in this repo. `terraform.tfvars` and all state files are gitignored.

## Design decisions

**Groups come from a map, rules don't.** Departments are a clean list, so one `for_each` block creates all of them and adding a department is a one line change. Group rules are declared individually on purpose. Real tenants have rules that have nothing to do with departments, and folding rules into the department map would break the first time one didn't fit.

**Rules reference groups, they don't hardcode IDs.** `okta_group.departments["Engineering"].id` instead of a pasted group ID. Terraform reads the reference, knows the group has to exist first, and the rule keeps working if the group is ever recreated. It also means the config works in any org, not just mine.

**The lock file is committed.** `.terraform.lock.hcl` pins the exact provider version and its checksums. Every `init` gets the same provider bytes, and a tampered provider fails verification instead of running with admin access to the tenant.

**Test users are fixtures, not a pattern.** In a real environment users come from an HRIS through SCIM, not from Terraform. They're here so the group rules have something to evaluate.

## Things I learned the hard way

**Renaming a resource label destroys the real object.** The label (`okta_user.eng_test_user`) is only Terraform's address for it, but changing it makes Terraform think one resource was removed and another added. I renamed four users and watched Terraform delete and recreate them. The fix is a `moved` block, which updates state without touching Okta. On a real tenant that rename would have wiped group memberships and factors.

**Terraform runs things in parallel unless it can see a dependency.** That same rename also failed: Terraform created the new users at the same time it was deleting the old ones, and Okta rejected the new logins as duplicates. Re-running fixed it. The underlying lesson is that ordering only exists where there's a reference.

## Next

- Move state to a remote backend in GCS
- Sign-on policies and an app with group assignments
- A drift detector on a Terraform-provisioned Linux host that reports anything changed by hand in the console
- CI that runs `fmt`, `validate`, and `plan` on every pull request
