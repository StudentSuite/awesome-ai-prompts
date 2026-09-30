# Reusable prompt: deployment runbook

Copy-paste the block below into any AI coding agent to deploy a service
safely - with a rollback plan, verified steps, and no surprises.

Keywords: deployment runbook, release checklist, rollout, go live, on call, steps

---

Prepare a safe deployment of `[version / branch]` of this application to
`[environment]`. A deployment is a risky operation: the plan must be precise,
verifiable, and reversible.

## What to produce

1. **Preflight checklist** - Everything that must be true before deploying:
   CI/tests green, migrations reviewed, env/config changes known, secrets in
   place, dependencies (DB, cache, external APIs) healthy, backups taken if
   the deployment mutates data.
2. **The deploy steps** - Exact, ordered commands (or the platform's steps):
   build/package, run migrations (before or after rollout - state which and
   why), update instances, verify. Include how config/secrets are supplied.
3. **Verification after deploy** - How to confirm the deployment actually
   works: health checks, smoke tests, logs to watch, key user flows to
   exercise. Include the specific checks, not "verify it works".
4. **Rollback plan** - The exact steps to revert to the previous version, and
   how to handle the tricky cases (schema migration already applied,
   half-rolled-out state, cache warm-up). State the trigger conditions for
   rolling back.
5. **Risk notes** - Known risks of this specific release (breaking changes,
   perf-sensitive features, data-affecting code) and how to watch for them.

## Method

- Read the repo's existing deploy scripts, CI/CD config, README, and any
  runbooks. Build on what exists; don't invent a parallel process.
- Verify commands where you can (check scripts, run read-only/`--dry-run`
  variants, confirm config paths and env var names exist). Don't fabricate
  commands you haven't validated.
- Match the environment's conventions (naming, logging, alerting).

## Rules

- Never run a real deployment without user confirmation, and never deploy to
  production from an unreviewed/unverified plan.
- Never put secrets in the runbook; reference how they're supplied.
- If something in the plan is uncertain, mark it as needing confirmation -
  don't paper over it.
