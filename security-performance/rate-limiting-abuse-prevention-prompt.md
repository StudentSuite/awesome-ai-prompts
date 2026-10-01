# Reusable prompt: rate limiting and abuse prevention

Copy-paste the block below into any AI coding agent to set rate limits that
hold under abuse across instances, with the algorithm, store, and failure mode
chosen on purpose.

Keywords: rate limiting, abuse prevention, token bucket, throttling, retry after

---

Add rate limiting and abuse prevention to `[the endpoints or service]` in this
repository. Public surfaces get abused within days, so pick per-route limits
tiered by identity, back the counters with a shared store, and prove the limits
trip and that traffic recovers afterwards.

## Steps

1. **Inventory the exposed surface** - List every endpoint reachable without a
   human, what it costs to serve (a database scan, a model call, a payment call,
   a cache hit), and whether it is authenticated. Cost per request sets the
   limit; one number applied to both a search endpoint and a login attempt is
   wrong at both ends.
2. **Set limits per route and per identity** - For each endpoint, choose a tier
   and write the reasoning: anonymous IP tier, authenticated user tier, and an
   admin or partner tier with a higher ceiling. Name the key you count on
   (user id, API key, IP, or a combination) and how a caller who rotates IPs or
   keys still hits a ceiling. One global number is a starting point, not a
   design.
3. **Choose the algorithm and write the rationale** - Compare token bucket
   (cheap, permits bursts), sliding window log or counter (exact, more memory
   and round trips), and leaky bucket (smooths output for expensive work). Tie
   the choice to the traffic shape: a spiky consumer API wants a bucket, a
   scraping target wants a window, a queue-backed job wants a leak. Record the
   capacity, refill rate, and window length as numbers, not adjectives.
4. **Get the 429 right** - Return a real 429 with a `Retry-After` header
   carrying delta-seconds a client can act on, the standard limit and remaining
   headers, and a body naming the tier and the reset. Decide explicitly whether
   the limit is per route or global and document it, because a client cannot
   obey a limit it cannot see.
5. **Back the counters with a shared store** - Use a store every instance
   reads (Redis, or whatever the repo already runs) so limits hold across
   replicas, with key TTLs matching the window so counters expire on their own.
   Check for an existing client to reuse, and for in-process limiting that would
   silently multiply the effective limit by the replica count.
6. **Decide the failure mode on purpose** - When the store is unreachable,
   choose fail open or fail closed per endpoint and write down why: a cached
   read can fail open, a login or payment path should fail closed. Set a
   timeout so a slow store does not become the outage, and surface the decision
   in logs and metrics rather than in a comment.
7. **Prove the limits trip and traffic recovers** - Drive one identity past
   its ceiling with the repo's load tooling (k6, locust, artillery) against a
   staging environment: confirm 429s arrive with correct `Retry-After`, confirm
   a second identity is unaffected, confirm requests succeed again at the refill
   rate, and exercise the store-down path. Paste the numbers.

## Rules

- No limit ships without a test showing it tripping. An untested limit does not
  exist.
- Never rely on client-side or per-process-only counters as the sole control.
- Never leave the fail open or fail closed decision implicit in the code.
- Never rate limit on one unauthenticated value without a second key.
- Never send a 429 without `Retry-After` and a body a client can act on.

## Verification

Paste the route-to-tier table, the algorithm rationale with its numbers, real
429 responses with their `Retry-After` headers, a two-instance test showing the
second instance enforces the same limit, and the load test output including the
measured recovery window.
