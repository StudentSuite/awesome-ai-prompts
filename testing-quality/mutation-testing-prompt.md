# Reusable prompt: mutation testing

Copy-paste the block below into any AI coding agent to run mutation testing
and validate that your test suite actually catches real defects, not just
achieves coverage numbers.

Keywords: mutation testing, mutation score, test quality, meta testing, weak tests

---

Run mutation testing on `[module / file / test suite]` in this repository.
The goal: find tests that pass even when the code is broken - these are the
gaps where coverage lies.

## Steps

1. **Check the tooling** - Determine what mutation testing framework fits the
   repo's stack (Stryker for JS/TS, mutmut for Python, pitest for Java,
   cargo-mutants for Rust). Install and configure it following the repo's
   conventions. If none exists, set up the standard tool for the language.
2. **Run the baseline** - Execute mutation testing on the target module and
   record the baseline mutation score (killed / total mutations). Note which
   files and test files are covered.
3. **Analyze surviving mutants** - Examine every mutant that survived (tests
   passed despite the mutation). Categorize them:
   - **Trivially killed** - the mutant changed something the tests already
     cover but the assertion is too weak to catch it.
   - **Actually survived** - the mutant changed behavior the tests do not
     verify at all.
   - **Equivalent mutants** - the mutation is semantically identical to the
     original code (these can be ignored).
4. **Strengthen the tests** - For each meaningful surviving mutant, add or
   fix the test that should catch it. Strengthen assertions, add edge case
   tests, or add new test cases for untested code paths.
5. **Re-run and verify** - Run mutation testing again. The mutation score
   should improve. Confirm no existing tests broke from the changes.
6. **Report** - Summarize: starting score, number of mutants analyzed, number
   killed, equivalent mutants excluded, and final score. List the specific
   gaps that were fixed.

## Rules

- Never skip the equivalent mutant analysis - some mutations are genuinely
  unkillable and should not count against the score.
- Never add tests just to kill mutants if the mutant represents a change that
  doesn't matter in practice. Focus on meaningful behavior.
- If the mutation testing tool does not support the repo's language or
  framework, say so clearly instead of forcing an incompatible tool.
- Mutation testing is a complement to code coverage, not a replacement. Use
  both.
