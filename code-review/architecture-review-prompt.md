# Reusable prompt: architecture review [spec]

Copy-paste the block below into any AI coding agent to audit a repository's
architecture with evidence-backed scores and a prioritized refactoring plan -
the heavy format, because a wrong audit ships a misleading roadmap.

Keywords: architecture review, coupling, cohesion, module boundaries, design review, layering

---

Audit the architecture of this repository as a senior software architect.
Read-only: this produces a report, never diffs. Every claim must trace to a
file:line or a measured number - accuracy matters more than volume.

## Define the scope first

State all four before reading any code:

1. **Target** - Whole repo, or a specific module/directory/service? If the
   repo is large, propose the highest-value slice (core logic, public API
   surface, lines with the most ownership churn) and defend the cut.
2. **Platforms & stack** - Language(s), framework(s), build tooling, and
   whether this is a monorepo, a service mesh, a library, or an application.
3. **Inputs in scope** - Source, tests, build/config, scheduler and CI
   definitions, docs/ADRs. List what you are including.
4. **Out of scope** - Functional bug hunting, deep security and performance
   audits (they have their own prompts), and any code change. Audit-read only.

## What to produce

1. **Scorecard** - One score (0-10) per dimension below, plus a single Overall
   Architecture score. Anchor: 9-10 production-grade; 7-8 solid with specific
   weak spots; 5-6 functional but fragile; 3-4 needs rework; 0-2
   foundationally broken. Every score carries a file:line or measured
   justification - no bare numbers.

   Dimensions (non-overlapping - no finding is counted twice):

   1. Structure & modularity - component sizes, monoliths, god components,
      where to split/merge/relocate.
   2. Coupling & dependency direction - dependency direction, circular
      dependencies, hidden/tight coupling, boundary discipline.
   3. Abstractions & separation of concerns - poor or leaky abstractions,
      ownership clarity, accidental complexity.
   4. Duplication & dead code - duplicated or fragmented functionality;
      placeholder, obsolete, or redundant code.
   5. Maintainability & technical debt - how cheap change is, debt hotspots.
   6. Testing - coverage of critical paths, test health, what untested code
      risks.
   7. Documentation - architecture docs, README, drift between docs and
      behavior.
   8. Production readiness - error handling, security posture, performance
      risks, scalability, observability.

2. **Findings report** - Every finding, one template: Severity
   (Critical/Major/Minor), Evidence (file:line plus the reading that proves
   it), Impact (what breaks and who pays), Recommended fix (minimal first
   step, not a rewrite). Major/minor all get the same template - severity
   differs, detail does not.

3. **Architecture map** - The real boundaries: modules/packages/services,
   entry points, dependency direction, and any cycles. This is the shared
   picture the rest of the report hangs on.

4. **Top problems** - Up to ten, ranked, each traceable to a finding.

5. **Refactoring roadmap** - Prioritized: fix now (blocks current work or
   risks incidents), schedule (real cost, not urgent), accept and document.
   No big-bang rewrites; every entry names a first increment and how to
   verify it.

## Method

1. **Map first** - Identify the boundaries and dependency graph before judging
   any component. A component read in isolation is reliably misjudged.
2. **Measure before concluding** - Baseline the repo: largest files and
   functions, LOC per module, test counts and coverage on critical paths,
   build time. Prefer measured signals over adjectives.
3. **Read the actual code** - For each candidate finding, trace the calls in
   and out; confirm the coupling claim by reading both ends of the edge.
4. **Verify impact** - Keep only findings with an observable cost: a bug
   report touching the area, a slow step, repeated workarounds. Discard items
   with no demonstrated cost.
5. **Report, never fix** - Log findings only. Do not refactor, rename, or
   reformat.

## Verification

- [ ] Scope stated (target, platforms, inputs, out-of-scope) before any code
      was read.
- [ ] Every scorecard score carries a file:line or measured justification.
- [ ] Every finding uses Severity/Evidence/Impact/Fix, with evidence naming a
      concrete file:line.
- [ ] At most ten top problems, each traceable to a finding.
- [ ] Roadmap ordered by risk; every entry starts an increment, not a rewrite.
- [ ] Things swept and found clean are reported, not just the problems.
- [ ] No code, config, or docs were modified - the report is the only output.

## Rules

- Never modify, move, or delete code - this task produces a report only.
- Never report a finding without a file:line or measured trace; unprovable
  suspicions go in a separate "needs confirmation" list.
- Never count a problem in more than one dimension; each finding maps to
  exactly one.
- Never pad - five verified findings beat forty speculative ones.
- Never propose a rewrite; fixes must be incremental and verifiable.
