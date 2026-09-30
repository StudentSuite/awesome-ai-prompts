# Reusable prompt: git bisect debug

Copy-paste the block below into any AI coding agent to use git bisect to find
the exact commit that introduced a bug - binary search through history with a
verified test, not manual git log reading.

Keywords: git bisect, bisect, find the regression, good bad, history search, when did it break

---

Use git bisect to find the exact commit that introduced `[bug / regression /
behavior change]`. The goal: pinpoint the introducing commit so the fix is
targeted, not a guess.

## Steps

1. **Reproduce the bug** - Before touching git, confirm you can reproduce the
   bug on the current code. Document the exact steps, commands, and
   inputs that trigger it. If you can't reproduce it, stop and clarify the
   symptoms.
2. **Find a known-good commit** - Identify a commit where the behavior was
   correct. Use git log to find a recent commit before the bug was reported,
   or use a release tag. Verify the behavior is correct at that commit
   (build and test at that point, or check out and run).
3. **Write a test or script** - Create a minimal, non-interactive script or
   test that fails when the bug is present and passes when it's not. This is
   your bisect script. It must be deterministic and fast. Examples: a
   specific assertion, a curl command that returns the wrong status, a
   command that exits non-zero on the bug.
4. **Run git bisect** - Start the bisect session: `git bisect start`,
   `git bisect bad` (current), `git bisect good <commit>`. Let git bisect
   run your script automatically: `git bisect run ./test-script.sh`.
5. **Identify the commit** - Git bisect will output the exact commit hash
   that introduced the bug. Read the commit message, the diff, and the
   author to understand what changed and why.
6. **Verify** - Confirm the bug exists at the identified commit and does not
   exist at the commit before it. Read the diff to make sure it explains
   the regression.

## Rules

- Never bisect with a manual "does it look broken?" check - the test must
  be automated and deterministic.
- Never skip verifying the bisect result - confirm the commit is actually
  the introducing change.
- If the bisect run fails (build errors at intermediate commits), use
  `git bisect skip` or choose a narrower range rather than aborting.
- If the bug is in a dependency, bisect the dependency separately, not this
  repo's history.
