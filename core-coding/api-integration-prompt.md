# Reusable prompt: REST API integration

Copy-paste the block below into any AI coding agent to integrate an external
REST API into this codebase - typed, tested, and resilient, not a quick hack.

Keywords: api integration, http client, third party api, webhook, retry, rate limit

---

Integrate the `[API name / endpoint docs]` into this repository's codebase.
Read the actual API docs and the existing code before writing anything.

## Steps

1. **Read the API** - Understand the endpoints you need: request/response
   shapes, auth, rate limits, pagination, and error semantics. Read the actual
   docs, not just a guess from the URL.
2. **Match the codebase** - Use the existing HTTP client, error handling,
   logging, and config patterns. Do not introduce a new HTTP library unless
   the existing one can't do the job.
3. **Types & boundaries** - Define typed request/response models (or equivalent)
   matching the API contract. Keep the integration behind a small boundary so
   callers don't depend on the wire format.
4. **Handle the real world** - Timeouts, retries with backoff for transient
   failures, clear errors for 4xx/5xx, pagination, and rate-limit handling.
   No infinite retries, no swallowed errors.
5. **Auth & config** - Keep credentials in config/env/secrets, never hardcoded.
   Follow the repo's existing secret-handling conventions.
6. **Test** - Write tests for the integration's behavior: success path, error
   mapping, retries, and edge cases (empty responses, malformed payloads).
   Use the repo's existing test doubles (mocks/fixtures/cassettes), and
   confirm the test suite runs green.

## Rules

- Never paste sample code from API docs into the codebase as-is - adapt it to
  the repo's conventions.
- Verify your assumptions about the API against real responses where possible.
- If the docs and the live API disagree, flag it and verify rather than
  guessing which is right.
