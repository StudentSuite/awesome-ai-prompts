# Reusable prompt: code migration

Copy-paste the block below into any AI coding agent to migrate code between
frameworks, languages, or major versions - incrementally, with behavior parity
verified at every step.

Keywords: migration, port, framework upgrade, version bump, rewrite, codemod

---

Migrate `[source code / module / feature]` from `[current stack/version]` to
`[target stack/version]`. The rule: **behavioral parity at every step** - the
application must work before, between, and after the migration.

## Scope to cover

1. **Inventory** - Map every file, function, API endpoint, and configuration
   that needs to change. Identify shared code that does not need migration.
   Count the surface area so the effort is predictable.
2. **Deprecation and breaking changes** - Read the target version's migration
   guide and changelog. List every breaking change that affects this codebase
   with the specific file and line impacted.
3. **Risk assessment** - Identify the riskiest parts of the migration:
   dependencies that may not have compatible versions, behavioral differences
   that could cause silent bugs, and areas with weak test coverage.

## Method

1. **Establish a safety net** - Before changing anything, ensure the test suite
   passes on the current version. If coverage is thin, add characterization
   tests for the critical paths first - these capture current behavior so you
   can verify parity later.
2. **Migrate incrementally** - Work in small, independently deployable steps:
   migrate one module, one route, or one file at a time. Each step must leave
   the application in a working state. Never do a "big bang" rewrite.
3. **Handle dependencies first** - Upgrade or replace libraries that the
   migration depends on before touching application code. Verify each
   dependency update independently.
4. **Adapt the code** - Translate syntax, patterns, and APIs to the target
   stack. Follow the target stack's idioms, not a literal translation. Remove
   dead code left behind by the migration.
5. **Verify parity at each step** - After each incremental change, run the
   full test suite plus any manual smoke tests. Compare behavior against the
   baseline. If something changed intentionally, document the reason.
6. **Clean up** - Remove old code, old dependencies, old config, and migration
   scaffolding. Update documentation, README, and CI to reflect the new stack.

## Rules

- Never migrate everything at once and hope it works - small steps only.
- Never change behavior during a migration unless explicitly scoped as part of
  the migration.
- If a migration step requires more than 200 lines of changes, split it
  further.
- If the test suite does not pass after a step, stop and fix it before
  continuing - never stack broken changes.
- If a dependency has no compatible version for the target, flag it early
  rather than hacking around it.
