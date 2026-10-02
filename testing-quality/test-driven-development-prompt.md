# Reusable prompt: strict TDD

Copy-paste the block below into any AI coding agent to build code test-first.
Strict discipline - no code without a failing test, no skipping steps.

Keywords: tdd, test driven development, red green refactor, unit test, write test first, cycle

---

Implement `[feature/task]` using strict test-driven development in this
repository. The discipline is the point - follow the cycle exactly.

## Steps

1. **RED** - Write one failing test for the smallest useful piece of behavior.
   Run it and confirm it fails for the right reason (it fails because the
   behavior doesn't exist, not because of an error in the test itself).
2. **GREEN** - Write the minimum code to make that test pass. No extra
   features, no cleanup yet, no "while I'm here" changes.
3. **REFACTOR** - Clean up the code you just wrote while keeping the tests
   green. Remove duplication, improve naming, follow repo conventions.

Repeat until the feature is complete. Do not proceed to the next test while any
test is failing.

- Design the tests from the **outside in**: write the test the way a caller
  would use the code. Keep the tests focused on behavior and interface.
- Each test should cover one behavior. If a test is getting big, split it.
- Commit at logical points (a green commit per cycle is fine) with the repo's
  commit convention.
- At the end: run the full suite plus lint/format/type checks with the repo's
  tooling and confirm everything is green.

## Verification

- [ ] Every piece of production code was written after a failing test for it
      existed, and the failure was observed first.
- [ ] Each test was watched go red then green; nothing was implemented ahead of
      its test.
- [ ] Tests were written from the outside in, as a caller would use the code.
- [ ] Each test covers one behavior, and any that grew was split.
- [ ] Refactoring happened only while green.
- [ ] No failing test was deleted, disabled, or weakened to get to green.
- [ ] The full suite plus lint, format, and type checks run with the repo's own
      commands.

## Rules

- Never write production code before the failing test exists for it.
- Never delete, disable, or weaken a failing test to go green - the code must
  change.
- If a test is genuinely wrong (the requirement changed), update it and say so
  explicitly - don't quietly change tests to match implementation.
