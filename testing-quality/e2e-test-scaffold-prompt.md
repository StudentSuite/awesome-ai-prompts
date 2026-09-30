# Reusable prompt: end-to-end test scaffold

Copy-paste the block below into any AI coding agent to scaffold end-to-end or
integration tests - realistic scenarios with proper setup, not toy smoke tests.

Keywords: end to end tests, e2e, playwright, cypress, browser testing, integration tests

---

Scaffold end-to-end or integration tests for `[feature / workflow / route]`.
The goal: tests that verify real user flows work correctly, with realistic
fixtures and CI-ready setup.

## Steps

1. **Understand the flow** - Read the code for the user journey you are
   testing: entry point, all code paths, side effects (database writes, API
   calls, file system changes), and the expected final state. Trace the full
   path, not just the happy case.
2. **Identify what to test** - Prioritize flows that are high-risk or
   high-traffic: critical user journeys, complex multi-step processes, integrations
   with external services. Do not test things better covered by unit tests
   (pure logic, utilities).
3. **Set up the test environment** - Use the repo's existing test framework
   and fixtures. Set up the database state, mock external services where the
   repo uses test doubles, and configure any required environment variables.
   Follow the repo's conventions for test setup and teardown.
4. **Write realistic scenarios** - Test the full flow as a user would
   experience it: navigate to the page, fill the form, submit, verify the
   result. Include realistic data, not placeholder strings. Cover the happy
   path and the primary error paths.
5. **Add assertions at boundaries** - Assert on observable outcomes: the
   response status, the database state after the operation, the UI content
   rendered. Avoid asserting on implementation details (internal function
   calls, CSS class names).
6. **Verify the tests run** - Execute the test suite. Confirm the new tests
   pass and existing tests are not broken. Check that the tests are
   deterministic (no flakiness from timing, random data, or shared state).

## Rules

- Never write tests that depend on external services without mocks or
  testcontainers.
- Never skip teardown - each test must leave the environment clean for the
  next one.
- If the test requires more than 3 setup steps, extract them into shared
  helpers or fixtures.
- Tests that pass sometimes and fail sometimes are worse than no tests - fix
  flakiness before merging.
