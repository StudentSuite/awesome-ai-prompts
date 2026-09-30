# Reusable prompt: coverage gap analysis

Copy-paste the block below into any AI coding agent to find real coverage
gaps and fill them with tests that matter - not lines that bump the
percentage.

Keywords: test coverage, coverage gap, untested code, coverage report, what is not tested

---

Find the untested and under-tested parts of this repository and close the gaps
with meaningful tests. The goal is risk reduction, not a higher coverage
number.

## Steps

1. **Measure** - Run the repo's coverage tool (find it in `pyproject.toml`,
   `package.json`, `Makefile`, or CI config) and note the current coverage and
   where the red lines are.
2. **Prioritize by risk, not lines** - Rank uncovered code by how much damage
   a regression would cause: core logic, error handling, security-sensitive
   code, public APIs, and code most likely to change rank highest. Ignore
   trivial gaps (plain getters, dead code, generated files).
3. **Explain the gaps** - For each gap you target, state why it's risky and
   what behavior is unprotected. Don't write tests for code you haven't
   reasoned about.
4. **Write the tests** - Follow the repo's test conventions. Assert real
   behavior, including the failure and edge-case paths that are usually the
   uncovered ones (timeouts, bad input, empty results, partial failures).
5. **Verify** - Run the suite and the coverage report again. Report the
   before/after delta and, more importantly, what risk you removed.

## Rules

- Never add a test whose only purpose is to touch a line (e.g. calling a
  getter and ignoring the result). Coverage is a byproduct, not the target.
- Don't write tests for dead or unreachable code - flag it for removal instead.
- Don't weaken existing assertions to improve coverage.
- If a piece of code is painful to test, say so and suggest a small
  refactor rather than fighting it with a contrived test.
