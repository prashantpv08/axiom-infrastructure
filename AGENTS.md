# AGENTS.md

## Mission

Maintain reviewed Terraform configuration for Axiom's AWS environments without mixing infrastructure authority into application repositories.

## Rules

- Apply KISS and YAGNI: add only infrastructure required by an authorized environment and current SRS milestone; never create placeholder resources, modules, providers, or environments.
- Apply DRY by the Rule of Three: extract a reusable module only after multiple real environment compositions establish a stable shared contract; do not hide materially different security or lifecycle policies behind one module.
- Keep responsibilities and dependency direction explicit: reusable modules expose narrow inputs and outputs, environment composition owns environment policy, and application business logic stays outside Terraform.
- Keep one source of truth for versions, backend ownership, environment boundaries, and policy checks; CI must run the repository-owned checks using pinned tool versions.
- Fail closed: plans, credentials, state, unreviewed replacements, and unauthorized applies are prohibited, and repository policy must reject sensitive local artifacts.
- Never deploy to Vercel.
- Never create, update, or destroy AWS or other billable resources without explicit user authorization.
- Never commit Terraform state, secret-bearing plans, credentials, private keys, application secrets, or production data.
- Keep development, staging, and production in separate state and access boundaries.
- Use reviewed reusable modules only when a real environment needs them; do not create speculative placeholder modules.
- Pin provider and module versions when the first real configuration is introduced.
- Require formatting, validation, security checks, a reviewed plan, and rollback notes before any authorized apply.
- Treat every destroy or replacement plan as destructive and require exact target review.
