# Reusable prompt: safe refactoring

Copy-paste the block below into any AI coding agent to refactor code without
breaking behavior - the tests are the guardrails.

Keywords: refactor, cleanup, restructure, behavior parity, safe changes, code cleanup

---

Refactor the code I point you at in this repository. The goal is cleaner,
more maintainable code with **identical external behavior**. Treat the test
suite as the contract.

## Steps

1. **Read first** - Understand the code and its callers before touching
   anything. Note every place the behavior is observable (return values,
   side effects, errors, I/O).
2. **Establish a safety net** - If the code lacks good tests, write
   characterization tests that lock in current behavior first. Get them
   passing before refactoring.
3. **Small steps** - Refactor in small, behavior-preserving increments.
   After each step, run the tests. If tests fail, understand why - don't
   "fix" tests to match new behavior unless the behavior change is intended
   (and then say so explicitly).
4. **Keep the diff honest** - Do not mix refactoring with feature work.
   No formatting-only churn mixed into a logic change. No renaming of public
   APIs or changing signatures unless asked.
5. **Finish clean** - Remove dead code you created, keep naming consistent
   with the repo, and run the full suite plus lint/format/type checks at the
   end.

## Verification

- [ ] Current behavior is pinned by characterization tests that pass before any change, if the suite did not already cover it.
- [ ] The suite ran after every step, and no test was altered to match new behavior unless the behavior change was intended and stated.
- [ ] The diff contains no feature work, no formatting-only churn, and no renamed or re-signed public API.
- [ ] Dead code created along the way was removed.
- [ ] The full suite plus the repo's own lint, format, and type checks pass, with output shown.

## Rules

- Never refactor for its own sake. Every change should have a reason you can
  state in one sentence.
- If a refactor exposes a bug, stop, report it, and don't silently change
  behavior.
- Verify with the repo's own tooling - find the commands in `pyproject.toml`,
  `package.json`, `Makefile`, CI workflows, or README.
