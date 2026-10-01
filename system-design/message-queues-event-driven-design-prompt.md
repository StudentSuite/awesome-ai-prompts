# Reusable prompt: message queues and event-driven design

Copy-paste the block below into any AI coding agent to design event-driven
architecture that survives duplicates, reordering, and replays - with versioned
contracts, an explicit ordering guarantee, and a replay story.

Keywords: message queue, event driven, ordering, idempotent consumer, replay, partitioning

---

Design the event-driven architecture for `[what: order pipeline, notifications,
audit log, workflow]` in this repository. The rule: **at-least-once delivery
means every message may arrive twice, late, and out of order**. Design for that
explicitly rather than discovering it in production.

## Steps

1. **Draw the flow and name every event** - List producers, the broker, and
   every consumer, then name each message as a past-tense fact (`OrderPlaced`)
   rather than a command (`PlaceOrder`). A fact has no addressee; a command
   needs exactly one handler. Getting this wrong early is what turns a system
   into a tangle of hidden coupling.
2. **Write the schema contract per event** - For each event, define the version,
   the fields with types and which are required, and how unknown fields are
   treated by older consumers. State the compatibility rule you are holding
   yourself to: additive-only changes, or a major version bump. Keep events
   small; put large payloads behind a reference.
3. **Say what ordering you actually need** - Ordering is per partition or per
   key, never global. Decide which key carries the ordering requirement (a
   customer ID, an aggregate ID), and where an event must be ordered with
   respect to another, say how you enforce it. Then state plainly which
   orderings you are not guaranteeing.
4. **Make consumers idempotent** - At-least-once means duplicates are normal, so
   every consumer keeps a processed-message key or performs an idempotent
   write. Do not rely on the broker to deliver once. Note the retention of the
   dedupe record: it must outlive the maximum redelivery window.
5. **Design for replay from the start** - A replay is a normal operation:
   rebuilding a read model, backfilling after a bug, or testing a new consumer.
   Decide whether the broker retains history long enough to replay (a window, or
   retained forever), how a replay is marked so live consumers can distinguish
   it, and how a replayed consumer suppresses side effects like sending a real
   email.
6. **Handle poison messages deliberately** - Bound retries per message, then
   move it to a dead-letter queue with the error and payload. Say who gets
   alerted, how an operator inspects and replays a DLQ message, and what happens
   to ordering guarantees when a message is parked.
7. **Name the operational numbers** - Specify what you must watch: lag per
   partition, consumer error rate, DLQ depth, and throughput. State the alert
   thresholds and the partition count you are starting with, plus what should
   make you raise it.
8. **Trace the failure paths** - Walk and write down: duplicate delivery,
   out-of-order delivery, a consumer down for a day, a poison message mid
   partition, and a replay of the last week. State what the system looks like at
   the end of each.

## Rules

- Never assume exactly-once delivery. Assume duplicates and make consumers
  idempotent.
- Never rely on global ordering. Choose a key and enforce ordering per key.
- Never make a replay send real emails or charge real cards without an explicit
  dry-run path.
- Never add a consumer without a versioned contract it can be pinned to.
- Never ship without a DLQ and a stated replay procedure.

## Verification

Paste the event catalog with versions, the ordering key and what is explicitly
not guaranteed, the consumer idempotency mechanism and its retention, the
replay procedure including side-effect suppression, and the trace of all five
failure paths in step 8.
