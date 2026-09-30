# Reusable prompt: performance review

Copy-paste the block below into any AI coding agent to review code for
performance anti-patterns - with evidence and specific fixes, not vague
"make it faster" advice.

Keywords: performance review, slow code, profiling, hot spots, speed up, optimization

---

Review the performance of `[file / module / endpoint]` in this repository.
Find real inefficiencies and propose concrete fixes backed by evidence.

## Scope to cover

1. **Algorithmic complexity** - Identify O(n^2) or worse operations where O(n)
   or O(n log n) is achievable: nested loops over collections, repeated
   lookups in unindexed structures, unnecessary sorting.
2. **N+1 queries and calls** - Find patterns where a loop triggers individual
   database queries, API calls, or file reads that could be batched.
3. **Blocking I/O in hot paths** - Identify synchronous file reads, network
   calls, or database queries in request handlers or tight loops where async
   or batching would help.
4. **Memory and allocation** - Spot unnecessary copies of large data structures,
   string concatenation in loops, collections that grow unbounded, or objects
   retained longer than needed.
5. **Caching opportunities** - Identify repeated expensive computations or
   lookups that could be memoized or cached, and where the cache should
   invalidate.
6. **Frontend-specific** - Re-renders caused by unstable references, missing
   memoization, unoptimized images, large bundle sizes, layout thrashing,
   or excessive DOM manipulation.

## Method

1. **Read the code path** - Trace the execution from entry point to completion.
   Identify every operation and its cost. Do not guess - read the actual code.
2. **Cite evidence** - For each finding, reference the specific file:line and
   explain the performance impact with concrete numbers where possible (query
   count, loop iterations, memory size).
3. **Propose minimal fixes** - Suggest the smallest change that addresses each
   issue: an index, a batch query, an early exit, a memoization cache. Follow
   the repo's existing patterns.
4. **Estimate impact** - Rate each finding as High/Medium/Low impact based on
   how frequently the code path runs and how much time it saves.

## Rules

- Never flag something as slow without explaining why it is slow and what
  makes it measurable.
- Never recommend premature micro-optimizations (e.g. replacing a clear loop
  with a one-liner) unless profiling proves it matters.
- If the code is already performant, say so and stop - do not invent problems.
- Always verify that the proposed fix preserves correctness.
