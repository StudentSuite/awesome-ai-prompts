# Reusable prompt: resolve a GitHub issue

Copy-paste the block below into any AI coding agent to take a GitHub issue in
any repository from reading the ticket to a mergeable pull request, with the
failure reproduced, the root cause proven, and the fix verified against the
project's real checks.

Keywords: github issue, resolve issue, close issue, reproduce, bug issue, fix issue

---

Help me resolve the GitHub issue I point you at (`OWNER/REPO#N`). The goal is
a pull request a maintainer merges on the first or second review, not a patch
that looks plausible. An issue is not resolved until the failing behavior is
gone, a regression test catches it, and the project's own checks pass.

## Steps

1. **Understand the ticket** - Read the issue body and every comment.
   Identify the expected behavior, the actual behavior, the platform or
   environment details, and any reproduction steps. Restate the ask in one
   sentence and list the files you expect to touch. If a bug report lacks
   repro steps, expected vs actual, or environment details, ask for the
   specific missing piece before proceeding. If the issue is ambiguous or its
   premise looks wrong, stop and ask rather than guessing.
2. **Read the room** - Read `CONTRIBUTING`, `README`, `CODE_OF_CONDUCT`, and
   the issue/PR templates. Identify the project's test runner, lint and
   format commands, and how CI is configured. Match existing code style and
   patterns. Check the issue timeline for linked PRs, branches, or comments
   that show the work is already in flight.
3. **Reproduce before you fix** - For a bug, reproduce the failure first and
   capture the actual output. For a feature request, capture the current
   behavior the issue wants changed. A failure you cannot reproduce is a
   failure you cannot claim to fix. Reproduce at the point of failure: a unit
   test, a script, or the described manual steps, whichever is closest to the
   reported behavior.
4. **Find the root cause, do not guess it** - Trace the path from the entry
   point to the failure. Use the debugger, `git log -S`, `git blame`, and
   adjacent code as evidence. State the root cause in one or two sentences and
   point at the exact line or commit. If your fix does not explain the
   reproduced failure, you have the wrong root cause.
5. **Plan the smallest change** - State precisely what will change and why it
   resolves the root cause. Prefer the smallest change that fixes the issue
   while staying consistent with the surrounding code. If the maintainable fix
   is larger, say so and outline it rather than silently inflating scope.
6. **Implement with a regression test** - Make the change and add a test that
   fails against the pre-fix code and passes with the fix. The test must
   encode the behavior in the issue, not a weaker version of it. Update
   existing tests only when the fix changes intended behavior; explain any
   such change. If a test is impossible, prove the fix manually and say in the
   PR exactly how to reproduce the proof.
7. **Run the project's full verification pipeline** - Run the test suite,
   linter, formatter, and type checks exactly as CI runs them, before and
   after the change. Paste the outputs. A change that passes a targeted test
   but breaks the full suite is not done.
8. **Commit and open the PR** - Commit with the project's message style
   (often Conventional Commits). In the PR body describe what the issue is,
   the root cause, the fix, and how you verified it, and reference the issue
   with a closing keyword (`Closes #N`, `Fixes #N`) only if it truly resolves
   it. Follow the PR template. If the repo requires tests or docs for
   user-facing changes, include them.

## Rules

- Never claim you ran a check you did not run, and never claim a bug is fixed
  without showing the reproduced failure is gone.
- Do not fix adjacent issues discovered along the way; note them in a comment
  or the PR body so the maintainer can decide, but keep this change focused
  on the issue.
- No unrelated refactors, formatting churn, or dependency bumps mixed into a
  fix.
- Do not force-push after review unless the project expects it; add commits in
  response to feedback.
- If your change makes an existing test or documented behavior stale, that is
  a signal you may have the wrong fix: re-examine the root cause before
  editing the test.
- Never resolve the issue by weakening or removing a guard, check, or test
  unless the issue explicitly asks for it and you can justify why it is safe.

## Verification (required before opening the PR)

1. The reproduction from step 3 changed from failing to passing.
2. The regression test from step 6 fails on the pre-fix code (or the manual
   proof is repeatable).
3. The project's full check pipeline from step 7 passes and the outputs are
   in the PR description.
4. The PR diff contains only what the issue asked for, plus tests and docs.
