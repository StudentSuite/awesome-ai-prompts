# Reusable prompt: mutation testing

Copy-paste the block below into any AI coding agent to run mutation testing and
validate that your test suite actually catches real defects, not just achieves
coverage numbers.

Keywords: mutation testing, mutation score, test quality, meta testing, weak tests

---

Run mutation testing on `[module / file / test suite]` in this repository. The
goal: find tests that pass even when the code is broken - these are the gaps
where coverage lies.

## Steps

1. **Check the tooling** - Pick the framework that fits the stack (Stryker for
   JS/TS, mutmut for Python, pitest for Java, cargo-mutants for Rust) and
   configure it following the repo's conventions.
2. **Run the baseline** - Run mutation testing on the target module and record
   the baseline score (killed over total), noting which source and test files
   were in scope.
3. **Analyze surviving mutants** - For each mutant the tests failed to kill,
   decide which it is: a weak assertion that already covers the change, a
   behavior the tests never verify, or a genuinely equivalent mutant that can
   be ignored.
4. **Strengthen the tests** - For each meaningful survivor, fix the test that
   should have caught it: strengthen the assertion, add an edge case, or cover
   an untested path.
5. **Re-run and verify** - Run mutation testing again and confirm the score
   improved with no existing test broken.
6. **Report** - Starting score, mutants analyzed, killed, equivalent mutants
   excluded, final score, and the specific gaps that were fixed.

## Verification

- [ ] The mutation framework fits the language and the repo's build.
- [ ] A baseline mutation score is recorded before any test was added.
- [ ] Every surviving mutant was examined, and the equivalent-mutant analysis
      was not skipped.
- [ ] Tests were strengthened to kill meaningful mutants; no test was added for
      a meaningless one.
- [ ] Mutation testing was re-run and the resulting score reported, not just a
      claim.
- [ ] The report states the starting score, mutants analyzed, killed, and the
      reasoning behind any accepted survivor.

## Rules

- Never skip the equivalent mutant analysis - some mutations are genuinely
  unkillable and should not count against the score.
- Never add tests just to kill mutants if the mutant represents a change that
  doesn't matter in practice. Focus on meaningful behavior.
- If the mutation testing tool does not support the repo's language or
  framework, say so clearly instead of forcing an incompatible tool.
- Mutation testing is a complement to code coverage, not a replacement. Use
  both.
