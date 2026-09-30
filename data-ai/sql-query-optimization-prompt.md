# Reusable prompt: SQL query optimization

Copy-paste the block below into any AI coding agent to make a slow query fast
with proof - plans before and after, indexes justified, and regressions
checked.

Keywords: sql, slow query, query optimization, explain analyze, index, execution plan, speed up

---

Optimize the specified slow SQL query or query set. Work like a DBA: measure,
read the plan, change one thing, measure again. No index is added without
evidence it will be used.

## Steps

1. **Baseline** - Capture current runtime on realistic data volumes (not dev
   toy data) and save `EXPLAIN ANALYZE` (or equivalent) output. Note rows in
   and out, and where time goes (seq scan, sort, spill to disk).
2. **Diagnose** - From the plan, identify the dominant cost: missing index,
   non-sargable predicates (functions on indexed columns), N+1 patterns in
   app code, over-fetching columns/rows, bad join order, stale statistics.
3. **Fix one thing at a time** - Candidate moves: covering/partial/composite
   index matched to the actual predicate and sort; rewriting the query
   (sargable predicates, `EXISTS` instead of `COUNT` joins, window functions
   instead of self-joins); batching app-side round trips; denormalizing a hot
   aggregate. After each change, re-run EXPLAIN and compare.
4. **Count the costs** - Every index slows writes and consumes space: list
   the affected write paths and judge whether the trade is worth it. Drop or
   reject indexes the planner won't use.
5. **Guard the win** - Add a regression test or benchmark that fails if the
   query regresses past a threshold; write the migration for the index/change
   with a rollback path and note lock implications on big tables
   (`CONCURRENTLY` or equivalent).

## Output

Before/after plans and timings, the changes as migrations, and a plain-
language explanation of why the plan changed.

## Rules

- Never report "should be faster" - show measured before/after on realistic
  data.
- One hypothesis per iteration; if a change doesn't move the plan, revert it.
- Verify the result set is identical before and after - correctness first.
