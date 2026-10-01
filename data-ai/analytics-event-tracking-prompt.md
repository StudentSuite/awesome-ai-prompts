# Reusable prompt: analytics event tracking that does not rot

Copy-paste the block below into any AI coding agent to design and wire product
analytics events so they stay valid: one documented schema, one tracking plan as
the source of truth, client-side validation before send, minimized payloads, and
a test that proves events actually arrive.

Keywords: event tracking, tracking plan, event schema, pii, data quality

---

Instrument `[the product flow or feature]` in this repository with analytics
events that a data team can trust. Instrumentation rots silently: names drift,
payloads carry more than they should, and half of it never arrives. Deliver a
documented schema, a plan that is the source of truth, validation before send,
and an end-to-end proof of delivery.

## Steps

1. **Start from the questions** - Write the decisions this data must support
   (which funnel step, which retention curve, which experiment metric), then
   list only the events those decisions need. Every event must trace to a named
   question, and every question must have a stated grain.
2. **Write the tracking plan first** - One checked-in document, for example
   `[tracking-plan.md]`, is the single source of truth. For each event give:
   name, trigger, when it fires, properties with types and allowed values, the
   user and session context attached automatically, the funnel it belongs to,
   and the questions it serves. Require a PR review against this document.
3. **Fix a naming convention and enforce it** - Pick one convention, object plus
   action (`checkout_started`) or past-tense object plus past-tense action
   (`checkout_completed`), lowercase snake_case, no abbreviations, no version
   numbers in names. Namespace reserved prefixes (`session_start`, `page_view`,
   `click`, `error`) so client libraries cannot collide with product events.
   Write the convention as a CI lint rule, not a wiki page.
4. **Model the schema as data** - Keep the schema in a machine-readable file
   (JSON Schema, YAML, or typed definitions) that generates the types used by
   both the client and the warehouse. Each property declares type, required or
   optional, allowed enum values, and whether it is user-identifying. Prefer
   enums over free-text strings so downstream queries need no cleanup.
5. **Minimize and classify the payload** - Send only what the question needs.
   Never send email addresses, phone numbers, full names, precise location, raw
   user IDs, free-text queries with personal data, or URLs with tokens. Use a
   pseudonymous internal ID, mapped to a real user only in an approved warehouse
   table. Classify each property as non-identifying, pseudonymous, or
   restricted, and keep restricted fields out of the default payload.
6. **Validate on the client before send** - In development and CI, assert every
   event against the schema: required fields present, types correct, enum values
   legal, no forbidden property names present. Reject and log the violation
   instead of sending it, loud in development but never blocking the user flow.
   Also fail on duplicate fire where the trigger is defined.
7. **Prove delivery end to end** - Write a test that emits every event in the
   plan and asserts it arrives at the real destination: the SDK, the collector,
   and the warehouse table, verified by a count keyed on a unique run ID. A
   green network call is not proof the row is queryable.
8. **Keep it maintained** - Add a CI job that fails when code emits an event or
   property absent from the schema, or when the schema changes without a doc
   update. Track per-event volume and last-seen timestamp, and alert on an event
   going quiet: a dead event looks like a drop in usage.

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

## Verification

Paste the tracking plan, the schema file, the validation failure output for a
deliberately bad event, and the emitted payloads matched to destination rows
keyed on a unique run ID.
