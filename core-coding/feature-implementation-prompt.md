# Reusable prompt: end-to-end feature implementation

Copy-paste the block below into any AI coding agent to build a feature from
spec to shipped, with verification at every stage.

Keywords: implement a feature, end to end, ship it, vertical slice, wiring, acceptance criteria

---

You are implementing a feature in this repository. Work end-to-end: understand
the requirement, design a minimal solution that fits the existing
architecture, implement it, verify it, and leave the codebase clean. Never
guess - read the relevant code first and verify every claim you make.

## Steps

1. **Understand** - Read the feature request/issue carefully. Read the code
   this touches: the files, their callers, and the surrounding tests. Ask
   clarifying questions if the requirement is ambiguous or conflicts with the
   existing design.
2. **Plan** - State your plan before writing code: the files you will change,
   what each change does, the edge cases you'll handle, and how you'll verify.
   Do not start editing until the plan is agreed.
3. **Design to fit** - Follow the repo's existing patterns, conventions, and
   architecture. Do not introduce a new library, pattern, or directory unless
   it's clearly warranted - prefer the boring, idiomatic option.
4. **Implement** - Write the smallest change that satisfies the requirement.
   Handle edge cases (empty input, missing data, errors, timeouts). Do not add
   speculative features or refactor unrelated code.
5. **Test** - Add or update tests that assert the actual behavior, including
   the key edge cases. Run the full test suite plus lint, format, and type
   checks using the repo's own tooling (check `pyproject.toml`, `package.json`,
   `Makefile`, CI workflows, or README). Fix whatever breaks.
6. **Verify the behavior** - Exercise the feature as a user would where
   practical, not just through mocked paths.
7. **Document** - Update README/CHANGELOG only if the feature changes user
   behavior or setup. Keep it accurate and in the repo's voice.
8. **Self-review** - Re-read your diff as a reviewer: is the fix correct, are
   the tests meaningful, is there anything dead, duplicated, or confusing?

## Verification

- [ ] The relevant code, its callers, and the surrounding tests were read before editing.
- [ ] The plan named the files to change, the edge cases, and how it would be verified before implementation started.
- [ ] The change is the smallest one that satisfies the requirement, with no speculative features and no new dependency.
- [ ] Tests assert real behavior including edge cases, and the repo's own test, lint, format, and type commands were run, with output shown.
- [ ] The feature was exercised as a user would where practical, and the diff was re-read as a reviewer.
- [ ] No commented-out code, debug prints, or TODOs remain, and unrelated code is untouched.

## Rules

- Never modify unrelated code. If you find a pre-existing bug, flag it as a
  note instead of fixing it silently.
- Never leave commented-out code, debug prints, or TODOs you created.
- Verify before claiming: run the commands, don't assume they pass.
- If a step turns out to be harder than planned, stop and report rather than
  hacking around it.
- Commit in small, logical commits following the repo's commit convention
  (check `git log`), and only when the work is verified.
