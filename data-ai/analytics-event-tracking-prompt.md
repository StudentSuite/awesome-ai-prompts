# Reusable prompt: analytics event tracking that does not rot

Copy-paste the block below into any AI coding agent to design and wire product
analytics events so they stay valid: one documented schema, one tracking plan
as the source of truth, client-side validation before send, minimized payloads,
and a test that proves events actually arrive.

Keywords: event tracking, tracking plan, event schema, pii, data quality

---

Instrument `[the product flow or feature]` in this repository with analytics
events that a data team can trust. Instrumentation rots silently: names drift,
payloads carry more than they should, and half of it never arrives. Deliver a
documented schema, a plan that is the source of truth, validation before send,
and an end-to-end proof of delivery.

## Steps

1. **Start from decisions** - List only events needed for named decisions
   (funnel, retention, experiment). Each must trace to a question with a stated
   grain.
2. **Define the tracking plan** - Keep one checked-in source of truth. For each
   event: name, trigger, when, properties (type, allowed values), automatic
   context, funnel, and questions. Require PR review.
3. **Standardize and model** - Use object+action (or past tense), lowercase
   snake_case, no abbreviations or version numbers. Namespace reserved prefixes.
   Maintain a machine-readable schema (JSON Schema/YAML) generating types for
   client and warehouse; prefer enums.
4. **Minimize and validate** - Send only what is needed. Classify properties as
   non-identifying, pseudonymous, or restricted; never include PII. Validate
   against schema in dev/CI and reject violations without blocking user flow.
5. **Prove delivery** - Test that every planned event arrives at SDK, collector,
   and warehouse, keyed by a unique run id. Add CI to fail on schema mismatches
   and alert when any event goes quiet.

## Verification

- [ ] The tracking plan and the machine-readable schema are pasted, and every
      event traces to a named question.
- [ ] Every property is classified non-identifying, pseudonymous, or
      restricted, with no PII in any default payload.
- [ ] The validation output for a deliberately bad event is shown, and it
      rejected rather than sent.
- [ ] Emitted payloads are matched to destination rows keyed on a unique run
      id, through collector and warehouse.
- [ ] The CI lint rule for naming exists and the repo's own schema check runs
      in CI.

## Rules

- The tracking plan document and the machine-readable schema are the source of
  truth. Code that disagrees with either is a defect, not a special case.
- No PII in event payloads, ever. If a question cannot be answered without it,
  the question changes; do not bend the payload rules.
- Never let instrumentation failure block the user flow; log and continue.
- Every event carries enough context (user, session, app version, platform) to
  be segmented without guessing.
- Rename by schema version, not by editing history. A changed event name is a
  new event, and the old one keeps its historical data intact.
