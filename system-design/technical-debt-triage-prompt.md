# Reusable prompt: technical debt triage

Copy-paste the block below into any AI coding agent to inventory a codebase's
technical debt and get a prioritized paydown plan grounded in evidence, not
vibes.

Keywords: technical debt, triage, prioritization, payoff, maintenance plan, what to fix first

---

Inventory the technical debt in this repository and produce a triaged,
prioritized paydown plan. Debt means anything that makes change slower or
riskier than it should be: tangled modules, missing tests on critical paths,
outdated dependencies, drift between docs and behavior, TODO clusters.

## Steps

1. **Survey** - Scan the repo systematically: module coupling and size
   hotspots (largest files/functions), test coverage gaps on critical paths,
   dependency staleness, TODO/FIXME/HACK density, config sprawl, doc/code
   drift.
2. **Verify impact** - For each candidate item, confirm it actually hurts:
   find evidence (bug reports touching that area, slow CI stages, repeated
   workarounds). Discard items with no observable cost.
3. **Quantify crudely but honestly** - Estimate effort (S/M/L) and the risk
   of leaving it (what breaks, what it blocks). Prefer measured signals (test
   counts, bundle size, build time) over adjectives.
4. **Triage** - Sort into: fix now (blocks current work or risks incidents),
   schedule (real cost, not urgent), accept (cost exceeds payoff - document
   why), delete (dead code/config - removing beats refactoring).
5. **Plan** - For "fix now" and "schedule" items: a concrete first step, how
   to do it incrementally without a big-bang rewrite, and how to verify the
   improvement (metric before/after).

## Output

A table: item, evidence, effort, risk of inaction, verdict, first step. Then
the top three actions you would take this week and why.

## Rules

- No drive-by refactoring: this task produces a plan, not diffs, unless asked.
- Do not pad the list - ten real debts beat forty speculative ones.
- Dead code is debt too: recommend deletion where behavior isn't referenced.
