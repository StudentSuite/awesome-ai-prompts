# Reusable prompt: performance optimization

Copy-paste the block below into any AI coding agent to find real bottlenecks
and fix them with evidence - never guess-and-tune.

Keywords: performance optimization, bottleneck, slow, latency, speed up, make it fast

---

Optimize the performance of `[feature / endpoint / function / hot path]` in
this repository. The rule: **measure first, prove every change**.

## Steps

1. **Establish a baseline** - Find or build a way to measure the current
   behavior: a benchmark, profiling run, request latency, or load test. Use the
   repo's existing tooling where possible (pytest-benchmark, k6, flame graphs,
   `top`/`time`, browser DevTools). Record the baseline number.
2. **Find the real bottleneck** - Profile and locate the actual hotspot. It is
   almost never where you guess. Read the code path and identify what is
   actually slow: N+1 queries, repeated work in a loop, blocking I/O in a hot
   path, naive data structures, excessive allocations, or a bad algorithm. Cite
   the evidence (profile output, file:line).
3. **Fix the smallest thing** - Apply the minimal change that removes the
   bottleneck while preserving behavior. Prefer the boring fix (an index, a
   cached value, an early exit) over clever hacks. Follow repo conventions.
4. **Prove it** - Re-run the same measurement. Report before/after numbers. If
   the change doesn't measurably help, revert it and say so - don't keep a
   "probably faster" change.
5. **Verify correctness** - Run the test suite and the repo's checks. A fast
   but broken change is a failure.
6. **Document** - Note the trade-off in the changelog or a comment only where
   the repo expects it (e.g. a behavior change or a config knob).

## Verification

- [ ] A measurement harness exists and the baseline number is recorded before
      any change.
- [ ] The hotspot was located with a profile, and the profile output is shown.
- [ ] Nothing was changed that the profile did not implicate.
- [ ] The same measurement was re-run, with before and after numbers reported.
- [ ] The full suite passes, so the win did not come from a correctness trade.
- [ ] Any trade-off (memory, complexity, portability) is stated explicitly.

## Rules

- No premature optimization. If nothing is measurably slow, say so and stop.
- Never sacrifice clarity, correctness, or security for a marginal gain.
- Never micro-optimize without data (avoid "this loop could be a list
  comprehension" without evidence it matters).
- If the win comes with a trade-off (memory, complexity, portability), state it
  plainly.
