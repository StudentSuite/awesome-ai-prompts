# Reusable prompt: rate limiting and abuse prevention [spec]

Copy-paste the block below into any AI coding agent to add rate limits that
hold across replicas and survive abuse. Use the heavy format when a wrong
limit is an outage or an open door: public, unauthenticated, or expensive to
serve endpoints, where failure is expensive.

Keywords: rate limiting, abuse prevention, token bucket, throttle, retry after

---

Add rate limiting and abuse prevention to `[the endpoints or service]` in this
repository. Public surfaces get abused within days, so choose per-route limits
tiered by identity, back the counters with a shared store, and prove the
limits trip under abuse and that traffic recovers afterwards.

## Define the scope first

State each decision below in one line before writing any limiter code. Treat
them as decisions you can revise, not questions for the user.

1. **Endpoints in scope** - List every endpoint reachable without a human, as
   `METHOD /path`, with what it costs to serve: a database scan, a model call,
   a payment call, or a cache hit. Cost per request sets the limit.
2. **Identity model** - Name the key you count on per tier: anonymous IP,
   authenticated user id, API key, or per-tenant. State how a caller who
   rotates IPs or keys still hits a ceiling.
3. **Inputs and outputs** - Inputs: the traffic shape you expect (requests
   per second, burst size, seasonality). Outputs: the limits, the store, and
   the response headers a client reads to back off.
4. **Out of scope** - WAF rules, bot fingerprinting, CAPTCHAs, billing
   quotas, and any endpoint with a human typing in front of it.

## What to produce

1. **Limit tier table** - One row per endpoint: tier, key, limit, window, cost
   to serve, and the rationale. This is the matrix a reviewer reads first.
2. **Algorithm choice with rationale** - Pick token bucket (cheap, permits
   bursts), sliding window (exact, more memory and round trips), or leaky
   bucket (smooths output for expensive work). Tie the choice to the traffic
   shape, and record capacity, refill rate, and window length as numbers.
3. **429 contract** - The status, `Retry-After` in delta-seconds, the standard
   limit and remaining headers, and a body naming the tier and the reset.
   Decide and document whether the limit is per route or global.
4. **Shared counter store** - The store every replica reads, the key format,
   and the TTL matching the window. Cite the client you reused. This is the
   run log proving two instances enforce one limit.
5. **Failure-mode decision** - Per endpoint, fail open or fail closed, with
   the reason: a cached read can fail open, a login or payment path should
   fail closed. Include the store timeout and the log or metric that records
   it.
6. **Abuse coverage** - The patterns the limits cover: credential stuffing,
   scraping, enumeration, and burst flooding, each mapped to the tier that
   stops it.
7. **Load-test plan and evidence** - The tool, the scenario, the identities
   driven, and the raw output showing 429s, `Retry-After`, and recovery.

## Method

1. **Baseline the surface before limiting** - Measure the current requests per
   second and per identity on the in-scope endpoints and record the numbers.
   Exit: a baseline run log with the unthrottled rate for each endpoint.
2. **Inventory existing controls** - Search the repo for in-process limiters,
   middleware, and the store client already in use. Reuse before inventing.
   Exit: a file:line list of existing controls and the gap each leaves.
3. **Design the tiers and algorithm** - Fill the matrix and the algorithm
   rationale from the baseline shape. Exit: every endpoint has a tier, a key,
   numbers, and a written reason.
4. **Implement the limiter and the store** - One middleware path, a shared
   store, and a key builder per tier. Exit: the code reads and writes one
   store key, and no in-process counter is the sole control.
5. **Wire the 429 response** - Emit the status, `Retry-After`, and headers,
   and log the tier and the reset. Exit: a recorded request that receives a
   429 with a parseable `Retry-After`.
6. **Run the abuse load test** - Drive one identity past its ceiling, then
   confirm a second identity is unaffected and that the first recovers at the
   refill rate. Exercise the store-down path. Exit: the load output pasted as
   evidence, not summarized.

## Verification

- [ ] The scope names every in-scope endpoint, the identity key per tier, the
      traffic shape, and the out-of-scope list.
- [ ] The tier table gives each endpoint a limit, a window, and a
      cost-to-serve rationale; no two endpoints share a number by default.
- [ ] The algorithm is chosen with capacity, refill rate, and window recorded
      as numbers, and the rationale matches the measured traffic shape.
- [ ] A test shows the limit tripping under abuse traffic, with real 429s and
      a `Retry-After` a client can act on.
- [ ] A second identity on the same route is unaffected while the first is
      throttled.
- [ ] Two instances read one shared store and enforce the same limit, proven
      by a run log.
- [ ] Requests succeed again at the refill rate after the burst, with the
      recovery window measured.
- [ ] The store-down path is exercised and behaves as the fail-open or
      fail-closed decision states.
- [ ] Counters carry a TTL matching the window and expire on their own.
- [ ] Every assertion above cites a run log, a matrix, or a file:line, not a
      bare claim.

## Rules

- Never ship a limit without a test showing it tripping; an untested limit
  does not exist.
- Never rely on client-side or per-process-only counters as the sole control;
  they multiply by the replica count.
- Never leave the fail-open or fail-closed decision implicit in the code.
- Never rate limit on one unauthenticated value such as IP alone without a
  second key.
- Never send a 429 without `Retry-After` and a body a client can act on.
- Never apply one global number to both a cheap cache hit and an expensive
  payment call.
- Never let a slow store become the outage; set a timeout and log the outcome.
