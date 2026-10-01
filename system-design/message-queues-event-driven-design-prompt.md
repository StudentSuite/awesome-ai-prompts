# Reusable prompt: message queues and event-driven design [spec]

Copy-paste the block below into any AI coding agent to design an
event-driven flow that survives duplicate, late, and out-of-order
delivery. This is the heavy format for flows where a lost, duplicated,
or replayed event costs money, so the design is proven before it ships.

Keywords: message queue, event driven, ordering, idempotent consumer, replay

---

Design the event-driven flow for `[what: order pipeline, notifications,
audit log, workflow]` in this repository. The rule: at-least-once
delivery means every message may arrive twice, late, and out of order.
Design for that explicitly and prove it with recorded traces, not prose.

## Define the scope first

Decide these before any work starts; state each one in writing.

1. **The flow** - Name it, its trigger, and where it ends. List every
   producer, the broker, and every consumer by name.
2. **The broker** - Use the broker already in the stack. If none exists,
   justify the choice against the operational cost of adding one.
3. **Targets** - State throughput (messages per second), end-to-end
   latency, and availability as numbers.
4. **The ordering requirement** - Name the key that carries ordering (a
   customer, aggregate, or entity ID); never say "global ordering".
5. **Out of scope** - Name what this pass will not do: a new broker,
   cross-region replication, exactly-once delivery, other teams' flows.

## What to produce

1. **Event catalog** - A table with one row per event: its name as a
   past-tense fact (`OrderPlaced`, not `PlaceOrder`), its version, each
   field with a type and required flag, the compatibility rule it holds
   to, and where the schema lives.
2. **Ordering key and non-guarantees** - The key that carries ordering,
   and an explicit list of the orderings that are not guaranteed.
3. **Consumer idempotency design** - Per consumer, the dedupe key or
   idempotent write, and the retention of the dedupe record, which must
   outlive the maximum redelivery window.
4. **Replay and backfill procedure** - How far history is retained, how
   a replay is marked so live consumers can distinguish it, and how
   side effects are suppressed, including the dry-run path.
5. **DLQ operations** - The bounded retry count, who is alerted, how an
   operator inspects a parked message, and the command to replay it.
6. **Failure-path traces** - One recorded trace each for duplicate
   delivery, out-of-order delivery, a consumer down for a day, a poison
   message mid-partition, and a one-week replay.

## Method

Run these phases in order; each has an exit condition.

1. **Baseline the flow** - If the flow exists, measure current
   throughput, latency, error rate, and lag before touching anything. If
   it is greenfield, write the targets as the baseline to beat. Exit:
   numbers are recorded, not estimated.
2. **Draw the flow and name every event** - Producers, broker, and
   consumers, then the event catalog. Exit: every hop and every event is
   named and versioned.
3. **Fix ordering per key** - Choose the ordering key and write the
   non-guarantees. Exit: the key and the full non-guarantee list are
   written.
4. **Harden consumers** - Give each consumer a dedupe mechanism and a
   retention longer than the redelivery window. Exit: no consumer relies
   on the broker to deliver once.
5. **Design replay and backfill** - Set the retention, the replay
   marker, and side-effect suppression. Exit: a dry-run path exists and
   a one-week replay was traced.
6. **Wire DLQ operations** - Bound retries, alert on depth, and record
   the inspect and replay commands. Exit: an operator can replay a
   parked message from the runbook alone.
7. **Trace the five failure paths** - Exercise each path and record its
   end state. Exit: all five traces end with a stated system state.
8. **Re-measure** - Repeat the baseline measurements. Exit: measured
   numbers are compared with the targets.

## Verification

- [ ] Every event is a past-tense fact and carries a version, field
      types, required flags, and an additive-only or major-version
      compatibility rule.
- [ ] The ordering key is named, and the orderings explicitly not
      guaranteed are listed.
- [ ] Every consumer has a dedupe key or idempotent write, with a
      retention that outlives the maximum redelivery window.
- [ ] A duplicate delivery was traced and the consumer produced no
      second side effect.
- [ ] An out-of-order delivery was traced and either the final state is
      correct or the divergence is explained.
- [ ] A consumer down for a day was traced, and recovery or backfill is
      specified.
- [ ] A poison message mid-partition was traced and parked without
      blocking the partition indefinitely.
- [ ] A one-week replay was traced with side effects suppressed, and
      the dry-run path is documented.
- [ ] DLQ alerting, inspection, and replay are documented with the
      exact commands to run.
- [ ] Throughput, latency, and lag are measured and compared with the
      stated targets, not estimated.
- [ ] No part of the design relies on exactly-once delivery or global
      ordering.

## Rules

- Never assume exactly-once delivery; assume duplicates and make
  consumers idempotent.
- Never rely on global ordering; choose a key and enforce ordering per
  key.
- Never add a consumer without a versioned contract it can be pinned
  to.
- Never ship without a DLQ and a stated replay procedure.
- Never let a replay send a real email, charge a real card, or mutate an
  external system without an explicit dry-run path.
- Never introduce a new broker when one is already in the stack unless
  the operational cost is justified in writing.
- Never claim a delivery, ordering, or replay property without a run
  log or trace to back it.
