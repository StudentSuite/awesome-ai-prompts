# Reusable prompt: contract testing

Copy-paste the block below into any AI coding agent to set up consumer-driven
contract tests between services, so API drift is caught in CI before it hits
production.

Keywords: contract testing, api contract, pact, schema compatibility, breaking api

---

Set up contract testing between this service and its consumers or providers.
Goal: each side verifies against a shared contract in CI, so breaking changes
fail builds instead of production integrations.

## Steps

1. **Map the interfaces** - List the HTTP/message interfaces this service
   provides and consumes, with their counterpart services. Pick the highest-
   churn or most critical interface to start with - one contract, end to end.
2. **Choose tooling that fits the stack** - Use an established framework (Pact
   and equivalents) matching the languages involved; prefer a pattern the repo
   already uses if one exists.
3. **Write consumer expectations as contracts** - Capture what the consumer
   actually calls: request to expected response shape and status, including
   error cases and empty collections. Contracts encode usage, not the
   provider's full schema.
4. **Verify on the provider side** - Replay contracts against the real provider
   (state set up via hooks/fixtures). Every mismatch is a finding: either a
   real break or an outdated expectation - resolve it explicitly.
5. **Wire the workflow** - Publish contracts on consumer CI; provider CI
   fetches and verifies them; gate merges on verification (broker or repo-based
   flow). Document the flow in CONTRIBUTING or the README.
6. **Grow gradually** - Add contracts interface-by-interface for critical
   paths. Delete contracts when the interaction dies; stale contracts erode
   trust in the whole suite.

## Verification

- [ ] Every interface the consumer depends on is listed, not just the obvious
      ones.
- [ ] Tooling matches the stack and the repo's existing test setup.
- [ ] Contracts are written from the consumer's expectations and replayed
      against the real provider.
- [ ] Contracts are verified in CI on both sides; a contract only checked
      locally is documentation.
- [ ] No contract was loosened to make a failing build green; the provider code
      changed instead.
- [ ] Contract tests complement, rather than replace, the integration smoke
      tests.

## Rules

- A contract nobody verifies in CI is documentation, not a test - wire it or
  drop it.
- Never loosen a contract just to make a failing build green; change the code
  or consciously version/bump the contract with the consumer's agreement.
- Contract tests complement, not replace, integration smoke tests.
