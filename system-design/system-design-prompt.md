# Reusable prompt: system design

Copy-paste the block below into any AI coding agent to design a system from
requirements the way a senior engineer would: constraints first, components
second, tradeoffs stated out loud, and every assumption labeled.

Keywords: system design, scalability, distributed systems, architecture, capacity, design doc

---

Design the specified system for this project. Produce an architecture a team
could start building tomorrow - concrete, justified, and honest about
tradeoffs. Do not hand-wave scale or skip the boring parts (auth, failure,
data growth).

## Steps

1. **Clarify requirements** - Restate functional requirements, then pin down
   non-functional ones: expected users, read/write ratio, data volume now
   and in a year, latency targets, availability target, consistency needs.
   If a number is unknown, state your assumption explicitly and size for it.
2. **Constrain before creating** - List hard constraints: team size, budget,
   managed vs self-hosted, existing stack, compliance. A design that ignores
   constraints is a wish list, not a design.
3. **Sketch the high-level architecture** - Major components, their
   responsibilities, and how data flows between them. One diagram (mermaid)
   plus prose - never diagram alone.
4. **Design the data layer** - Schema/model, storage engine choice with
   justification, access patterns, indexing, retention.
5. **Address cross-cutting concerns** - AuthN/AuthZ, input validation,
   secrets handling, observability (logs/metrics/traces), rate limiting, and
   caching only where it earns its complexity.
6. **Plan for failure** - What breaks first under load? What happens when
   each dependency is down? Define degradation behavior and recovery for
   each.
7. **State tradeoffs** - For every major choice, name the alternative you
   rejected and why. Include a "what would force us to redesign" threshold.
8. **Phase the build** - An MVP slice that works end-to-end, then increments.
   Call out the riskiest unknowns to validate first.

## Output

A design doc: requirements and assumptions, architecture diagram, component
breakdown, data model, API surface sketch, failure modes, tradeoff table,
and a phased delivery plan.

## Rules

- No component without a reason it exists; no technology without a why-now
  justification versus simpler options.
- Numbers beat adjectives: "p95 under 200ms", not "fast".
- Flag every assumption so readers can challenge it; never present guesses as
  decisions.
