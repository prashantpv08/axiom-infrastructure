# Axiom Infrastructure

Terraform repository for Axiom's future AWS environments. It is intentionally configuration-only during local product development.

## Boundaries

This repository will own reusable Terraform modules, environment composition, state-access policy, and infrastructure delivery controls. It must not contain product business logic, application credentials, Terraform state, secret-bearing plans, private keys, or copied production data.

No AWS account, backend, provider credentials, billable resource, or deployment is configured by the foundation commit. The first environment will be added only during the AWS private-beta milestone and only after explicit authorization.

## Planned layout

```text
modules/               # reusable, versioned infrastructure modules when implemented
environments/
  development/         # independent state and access boundary
  staging/
  production/
scripts/               # repository policy and verification scripts
```

Directories are created when their first reviewed configuration is implemented; empty placeholder modules are not maintained.

## Local checks

```bash
terraform fmt -check -recursive
terraform validate
./scripts/check-repository.sh
```

`terraform init` is not required until a real configuration is introduced. Never run `terraform apply` without explicit authorization and a reviewed plan.
