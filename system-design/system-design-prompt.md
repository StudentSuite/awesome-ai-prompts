# Reusable prompt: system design [spec]

Copy-paste the block below into any AI coding agent to design a system from
requirements the way a senior engineer would: constraints first, components
second, tradeoffs stated out loud, and every assumption labeled.

Keywords: system design, scalability, distributed systems, architecture, capacity, design doc

---

Design `[the system or feature]` for this project. Produce an architecture a
team could start building tomorrow - concrete, justified, and honest about
tradeoffs. Do not hand-wave scale or skip the boring parts (auth, failure,
data growth).

## Define the scope first

State all of the following before proposing a component. A design written
before its constraints are known is a wish list.

1. **Functional scope** - What the system does, restated from the requirement,
   and what it explicitly does not do.
2. **Load and targets** - Expected users, read/write ratio, data volume now and
   in a year, latency targets, availability target, and consistency needs. If a
   number is unknown, state the assumption explicitly and size for it.
3. **Hard constraints** - Team size, budget, managed versus self-hosted, the
   existing stack the design must live inside, and compliance obligations.
4. **Out of scope** - Name the parts you are not designing and who owns them.

## What to produce

A design doc containing: requirements and assumptions, an architecture diagram,
a component breakdown, the data model, an API surface sketch, failure modes, a
tradeoff table, and a phased delivery plan.

## Method

1. **Sketch the high-level architecture** - Major components, their
   responsibilities, and how data flows between them. One diagram (mermaid)
   plus prose - never diagram alone.
2. **Design the data layer** - Schema/model, storage engine choice with
   justification, access patterns, indexing, retention.
3. **Address cross-cutting concerns** - AuthN/AuthZ, input validation,
   secrets handling, observability (logs/metrics/traces), rate limiting, and
   caching only where it earns its complexity.
4. **Plan for failure** - What breaks first under load? What happens when
   each dependency is down? Define degradation behavior and recovery for
   each.
5. **State tradeoffs** - For every major choice, name the alternative you
   rejected and why. Include a "what would force us to redesign" threshold.
6. **Phase the build** - An MVP slice that works end-to-end, then increments.
   Call out the riskiest unknowns to validate first.

## Verification

- [ ] Requirements, load targets, constraints, and out-of-scope were all stated
      before any component was proposed.
- [ ] Every number in the design is a target or a labeled assumption, not an
      adjective.
- [ ] Every major choice names the alternative rejected and why it lost.
- [ ] Each dependency has a defined degradation behavior and recovery path.
- [ ] Auth, secrets handling, and observability are addressed, not deferred.
- [ ] The phased plan names the riskiest unknown and how it gets validated
      first.
- [ ] A "what would force us to redesign" threshold is stated.

## Rules

- No component without a reason it exists; no technology without a why-now
  justification versus simpler options.
- Numbers beat adjectives: "p95 under 200ms", not "fast".
- Flag every assumption so readers can challenge it; never present guesses as
  decisions.
