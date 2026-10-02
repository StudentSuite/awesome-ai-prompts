# Reusable prompt: code migration [spec]

Copy-paste the block below into any AI coding agent to migrate code between
frameworks, languages, or major versions - incrementally, with behavior parity
verified at every step.

Keywords: migration, port, framework upgrade, version bump, rewrite, codemod

---

Migrate `[source code / module / feature]` from `[current stack/version]` to
`[target stack/version]`. The rule: **behavioral parity at every step** - the
application must work before, between, and after the migration.

## Define the scope first

State all of the following before touching a file. Work cannot start until the
scope is written down and agreed.

1. **The move** - Name the exact source and target: `[current stack/version]`
   to `[target stack/version]`, plus the `[module or feature]` in scope. List
   the components explicitly out of scope so they are not silently migrated.
2. **The surface area** - Map every file, function, API endpoint, and
   configuration that has to change, and identify shared code that does not.
   Count it, so the effort is predictable.
3. **The breaking changes** - Read the target version's migration guide and
   changelog. List every breaking change that affects this codebase with the
   file and line it hits.
4. **The parity contract** - Define behavior parity concretely: the test
   suite, the smoke paths, and the outputs that must be identical before and
   after each step. Name anything deliberately excluded from parity.
5. **The risk** - Identify the riskiest parts: dependencies with no compatible
   target version, silent behavioral differences, and areas with weak coverage.

## What to produce

1. A written scope covering the five items above, confirmed before any edit.
2. Characterization tests covering the critical paths, added first so parity is
   measurable.
3. The migration as a sequence of small, independently deployable steps, each
   with its parity evidence.
4. A cleanup pass removing old code, dependencies, config, and scaffolding, plus
   the README, docs, and CI updates the new stack requires.

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

## Verification

- [ ] The scope above was written down and agreed before the first edit.
- [ ] The test suite passed on the source version before any change was made.
- [ ] Every migration step left the application in a working state, and the
      suite was run after each one.
- [ ] Each step's parity evidence is recorded: the tests that passed and the
      smoke paths that were exercised.
- [ ] Any intentional behavior change is documented with its reason, rather
      than slipped in as part of the port.
- [ ] No old dependency, dead code, or migration scaffolding is left behind.

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
