# Reusable prompt: resolve a GitHub issue

Copy-paste the block below into any AI coding agent to take a GitHub issue in
any repository from reading the ticket to a mergeable pull request, with the
failure reproduced, the root cause proven, and the fix verified against the
project's real checks.

Keywords: github issue, resolve issue, close issue, reproduce, bug issue, fix issue

---

Resolve the GitHub issue I point you at (`OWNER/REPO#N`). The goal is a PR a
maintainer merges on the first review, not a patch that looks plausible. The
issue is not resolved until the failure is gone, a regression test catches it,
and the project's own checks pass.

## Steps

1. **Understand the ticket and the project** - Read the issue body and every
   comment for expected vs actual behavior, environment details, and repro
   steps, then restate the ask in one sentence and list the files you expect to
   touch. Read CONTRIBUTING and README to find the test, lint, format, and CI
   commands, and check the timeline for PRs already in flight. If a report
   lacks repro steps, stop and ask.
2. **Reproduce, then find the root cause** - Capture the actual failing output
   first; a failure you cannot reproduce is one you cannot claim to fix. Trace
   from the entry point with the debugger, `git log -S`, and `git blame`, then
   state the root cause in one or two sentences pointing at the exact line. If
   your fix does not explain the failure, you have the wrong root cause.
3. **Implement the smallest change with a regression test** - Say precisely
   what changes and why it resolves the root cause, staying consistent with the
   surrounding code; if the maintainable fix is larger, outline it rather than
   inflating scope. Add a test that fails against the pre-fix code and passes
   with the fix, encoding the behavior in the issue, not a weaker version.
4. **Verify and open the PR** - Run the test suite, linter, formatter, and type
   checks exactly as CI runs them, and paste the outputs. Commit in the
   project's message style, and in the PR body describe the issue, root cause,
   fix, and verification, closing the issue only if it truly resolves it.

## Verification

- [ ] The bug was reproduced before the fix, with the failing output captured.
- [ ] The root cause is traced to the entry point and named, not guessed.
- [ ] A regression test fails on the old code and passes on the fix.
- [ ] The full verification pipeline ran, with outputs pasted, before the PR
      was opened.
- [ ] The diff is scoped to the issue; adjacent problems are noted, not fixed.
- [ ] No existing test or guard was weakened to make the fix pass.

## Rules

- Never claim you ran a check you did not run, and never claim a bug is fixed
  without showing the reproduced failure is gone.
- Never resolve the issue by weakening or removing a guard, check, or test
  unless the issue explicitly asks for it and you can justify why it is safe.
- No adjacent fixes, unrelated refactors, formatting churn, or dependency bumps
  in the same change; note them in a comment instead. If a change makes an
  existing test or documented behavior stale, re-examine the root cause before
  editing the test.
- Do not force-push after review unless the project expects it; add commits in
  response to feedback.
