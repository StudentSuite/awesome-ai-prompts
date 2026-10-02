# Reusable prompt: caching strategy

Copy-paste the block below into any AI coding agent to add caching that
actually pays for itself - with invalidation designed up front and hit rates
measured, not assumed.

Keywords: caching, cache, invalidation, ttl, staleness, redis, memcached

---

Design and implement caching for this application where measurement shows it
helps. Cache only what is measurably expensive and safely cacheable; wrong
caching is worse than no caching.

## Steps

1. **Measure first** - Identify the expensive operations worth caching (slow
   queries, hot endpoints, computed results) with numbers: latency, call
   frequency, cost per call. No measurement, no cache.
2. **Classify the data** - For each candidate: how fresh must it be, who can
   write it, is it user-specific or shared, what staleness is tolerable? This
   determines TTL, key design, and invalidation strategy.
3. **Choose layers deliberately** - Pick the cheapest layer that works: HTTP
   cache headers, in-process memoization, distributed cache (Redis and
   friends), CDN, materialized views. Justify each layer against a simpler
   alternative.
4. **Design keys and invalidation before writing code** - Keys must include
   every input that changes the result. Decide: TTL-only, explicit eviction on
   write, versioned keys, or event-driven invalidation - and state the stale
   window users could see.
5. **Implement with guardrails** - Bounded memory/size limits, stampede
   protection for hot keys (single-flight/locking), graceful behavior when the
   cache is down (fall through to source), and metrics: hit rate, latency,
   evictions.
6. **Verify** - Show before/after latency on the target path, prove
   invalidation works (write then read returns the new value within the
   promised window), and load-test the hot path.

## Verification

- [ ] Only measured-expensive operations were chosen as cache candidates.
- [ ] Each cached item's freshness requirement is stated, with the resulting
      stale-data window reported to its owner.
- [ ] No per-user data sits under a shared key, and no response varying by auth
      is cached publicly.
- [ ] Keys include every input that changes the response, and invalidation is
      defined before code was written.
- [ ] Cache size is bounded and stampede protection is in place.
- [ ] Before and after latency is shown on the target path, with correctness
      intact.

## Rules

- Never cache per-user data under a shared key, and never cache responses that
  vary by session or headers as if they were public.
- If you cannot define how and when an entry becomes invalid, do not add the
  cache yet.
- Report the stale-data window explicitly so its owner can accept it.
