# Reusable prompt: end-to-end test scaffold

Copy-paste the block below into any AI coding agent to scaffold end-to-end or
integration tests - realistic scenarios with proper setup, not toy smoke tests.

Keywords: end to end tests, e2e, playwright, cypress, browser testing, integration tests

---

Scaffold end-to-end or integration tests for `[feature / workflow / route]`.
The goal: tests that verify real user flows work correctly, with realistic
fixtures and CI-ready setup.

## Steps

1. **Understand the flow** - Read the code for the user journey: entry point,
   all code paths, side effects (database writes, API calls, filesystem
   changes), and the expected final state. Trace the full path, not just the
   happy case.
2. **Identify what to test** - Prioritize critical journeys, complex multi-step
   processes, and external integrations. Leave pure logic and utilities to unit
   tests.
3. **Set up the environment** - Use the repo's existing framework and fixtures,
   set up database state, mock external services where the repo already uses
   test doubles, and follow the repo's setup and teardown conventions.
4. **Write realistic scenarios** - Drive the flow as a user would: navigate,
   fill, submit, verify. Use realistic data rather than placeholder strings,
   and cover the happy path plus the primary error paths.
5. **Assert at boundaries** - Observable outcomes only: response status,
   resulting database state, rendered UI content. Not internal calls or CSS
   class names.
6. **Verify the tests run** - Execute the suite: the new tests pass, existing
   tests are unbroken, and results are deterministic with no flakiness from
   timing, random data, or shared state.

## Verification

- [ ] The flows chosen are the high-risk ones, and the reasoning is stated.
- [ ] The repo's existing e2e framework and harness were used rather than a new
      one.
- [ ] No test depends on an external service without a mock or fixture.
- [ ] Scenarios run as a user would, across the full flow, with realistic data.
- [ ] Assertions target observable outcomes at boundaries, not internal state.
- [ ] Teardown runs for every test and leaves the environment clean.
- [ ] Setup exceeding three steps was extracted into shared helpers, and the
      suite passes without flakes.

## Rules

- Never write tests that depend on external services without mocks or
  testcontainers.
- Never skip teardown - each test must leave the environment clean for the next
  one.
- If the test requires more than 3 setup steps, extract them into shared
  helpers or fixtures.
- Tests that pass sometimes and fail sometimes are worse than no tests - fix
  flakiness before merging.
