# Reusable prompt: background jobs and scheduled tasks

Copy-paste the block below into any AI coding agent to add async work that
survives retries, deploys, and duplicates - with idempotent handlers, bounded
retries, a dead-letter path, and metrics that show the queue is healthy.

Keywords: background job, queue, retry, idempotency, dead letter, cron, shutdown

---

Add background job processing for `[what: emails, image processing, webhooks,
periodic reports]` to this repository. The rule: **every job will run twice
eventually and every deploy kills work in flight**. Design for both, and prove
the handler is safe to run again.

## Steps

1. **Name the jobs and their triggers** - List each job with its schedule or
   event source, its expected duration, and whether a slow run should overlap
   the next one. A periodic job that can take longer than its interval needs
   either a lock or a skip-if-running policy; decide which, per job.
2. **Choose where the queue lives** - Use the queue or scheduler already in the
   stack. If there is none, say what you are adding and why (Redis list, SQS,
   a Postgres table with `FOR UPDATE SKIP LOCKED`, or a scheduler such as
   cron-with-lock). Keep the choice boring: the queue is not the product.
3. **Make handlers idempotent by design** - Running the same job twice must
   produce the same end state. Prefer idempotent writes (upsert by a natural
   key, `INSERT ... ON CONFLICT`) over read-then-write checks that race. Where
   a side effect is not idempotent, record a processed-key with the job ID
   before acting, and make that record part of the same transaction as the state
   change where possible.
4. **Bound the retries** - Retry transient failures with exponential backoff and
   jitter, capped at a concrete attempt count and a total time budget. Fail
   non-transient errors immediately: a malformed record will never succeed on
   the third try. Declare which errors are transient rather than retrying
   everything.
5. **Handle poison messages** - After the final attempt, move the job to a
   dead-letter queue or a failed table with the error and the payload. Say how
   an operator inspects and replays it. A queue with no DLQ is a queue that
   retries forever and hides the failure.
6. **Make it observable** - Track queue depth, age of the oldest job, success
   and failure counts per job type, and retry volume. These four answer "is
   the system keeping up" without reading logs. If a dashboard or metrics
   library exists, extend it; do not invent a second one.
7. **Drain on deploy and shutdown** - On shutdown, stop accepting new jobs, let
   in-flight work finish within a grace period, and return unfinished jobs to
   the queue rather than dropping them. A job killed mid-flight must be
   retryable, which follows from step 3.
8. **Verify the failure modes** - Run and paste: the same job enqueued twice,
   a job that fails then succeeds, a job that fails permanently and lands in the
   DLQ, a deploy mid-job, and two concurrent runs of the same periodic job.

## Rules

- Never write a handler whose correctness depends on running exactly once.
  Assume at-least-once delivery and design for it.
- Never retry indefinitely, and never retry an error that is not transient.
- Never drop a job on shutdown. Return it or let it be redelivered.
- Never ship a queue without a way to see depth and oldest-job age.
- Never call it done until the duplicate-enqueue test runs green.

## Verification

Paste the job inventory with triggers, the declared transient-error list, the
retry parameters, the DLQ location and replay procedure, and the results of all
five step 8 cases. Confirm the duplicate enqueue produced one logical effect.
