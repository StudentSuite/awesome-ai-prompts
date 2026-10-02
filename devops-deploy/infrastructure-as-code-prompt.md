# Reusable prompt: infrastructure as code

Copy-paste the block below into any AI coding agent to define or change cloud
infrastructure (Terraform/OpenTofu, CloudFormation, CDK, Pulumi) with the same
discipline as the rest of your code.

Keywords: infrastructure as code, terraform, cloud resources, drift, modules, provisioning

---

Set up / modify the infrastructure for this repository using
`[Terraform/OpenTofu/CloudFormation/CDK/Pulumi]`. Treat infrastructure as code:
reviewable, versioned, and safely applied.

## Steps

1. **Read the existing setup** - Find existing IaC, cloud configs, CI/CD
   references, and README instructions. Reuse and extend what exists; don't
   reinvent the layout. Match the repo's provider/module conventions.
2. **Design with intent** - Define only what the app actually needs: compute,
   storage, networking, IAM, DNS/security groups. Name resources consistently,
   tag them, and use variables for anything environment-specific. Keep modules
   small and reuse the provider's built-in modules over reinventing them.
3. **Least privilege** - Grant IAM roles/permissions as narrow as the app
   needs. No wildcard `*` actions or over-broad network rules without a reason
   stated in a comment. No secrets in the IaC code - use secrets manager/vars.
4. **State safety** - Remote state with locking (e.g. S3 + DynamoDB backend),
   never commit state files or `.tfstate` to the repo. State in the README how
   state is managed.
5. **Plan before apply** - Run `plan` and review the diff before any apply.
   Never `apply` with `-auto-approve` unless the user explicitly confirms, and
   never apply a plan that creates/destroys resources you didn't intend.
6. **Verify** - Validate the config (`terraform validate`, `cdk synth`, etc.).
   If possible, run a plan against the real environment and confirm it matches
   intent. Flag anything destructive.
7. **Document** - README gets a short "infrastructure" section: what exists,
   how to plan/apply, and where state lives.

## Verification

- [ ] The existing IaC, cloud config, and CI/CD definitions were read before
      anything was written.
- [ ] IAM roles are as narrow as the app's actual calls, and the justification
      is stated.
- [ ] Remote state is configured with locking, so two applies cannot race.
- [ ] `plan` output was reviewed before any apply, and the diff matches the
      intended change.
- [ ] The config validates (`terraform validate`, `cdk synth`, or equivalent),
      with output shown.
- [ ] Nothing was destroyed or resized without explicit confirmation, and no
      secret is hardcoded or committed.
- [ ] The README gained an infrastructure section describing what exists and
      how to reach it.

## Rules

- Never destroy or resize resources without explicit user confirmation.
- Never hardcode secrets; never commit credentials or private keys.
- If the cloud setup can't be validated without real credentials, say so and
  produce the config plus a clear plan-verification step for the user.
