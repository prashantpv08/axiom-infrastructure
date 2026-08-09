# AGENTS.md

## Mission

Maintain reviewed Terraform configuration for Axiom's AWS environments without mixing infrastructure authority into application repositories.

## Rules

- Never deploy to Vercel.
- Never create, update, or destroy AWS or other billable resources without explicit user authorization.
- Never commit Terraform state, secret-bearing plans, credentials, private keys, application secrets, or production data.
- Keep development, staging, and production in separate state and access boundaries.
- Use reviewed reusable modules only when a real environment needs them; do not create speculative placeholder modules.
- Pin provider and module versions when the first real configuration is introduced.
- Require formatting, validation, security checks, a reviewed plan, and rollback notes before any authorized apply.
- Treat every destroy or replacement plan as destructive and require exact target review.
