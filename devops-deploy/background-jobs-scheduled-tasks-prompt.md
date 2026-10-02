# Reusable prompt: background jobs and scheduled tasks

Copy-paste the block below into any AI coding agent to add async work that
survives retries, deploys, and duplicates - with idempotent handlers, bounded
retries, a dead-letter path, and metrics that show the queue is healthy.

Keywords: background job, queue, retry, idempotency, dead letter, cron, shutdown

---

Add background job processing for
`[what: emails, image processing, webhooks, periodic reports]` to this
repository. The rule: **every job will run twice eventually and every deploy
kills work in flight**. Design for both, and prove the handler is safe to run
again.

## Steps

1. **Jobs and triggers** - List each job with its schedule or event source, expected duration, and
   timeout; if a periodic job can outrun its interval, pick a lock or
   skip-if-running.
2. **Where the queue lives** - Use the queue or scheduler already in the stack; if there is none, say what you
   add (`FOR UPDATE SKIP LOCKED`, SQS, a Redis list, cron-with-lock) and why.
3. **Idempotent handlers** - The same job twice must give the same end state: upsert by a natural key or
   `INSERT ... ON CONFLICT`. Record a processed key with the job ID for
   non-idempotent effects.
4. **Bounded retries** - Exponential backoff with jitter, capped at a concrete attempt count and a total
   time budget. Declare which errors are transient; a malformed record never
   succeeds on retry.
5. **Poison messages** - After the last attempt, move the job to a dead-letter queue or failed table
   with the error and payload, and say how an operator inspects and replays it.
6. **Observability and shutdown** - Track queue depth, oldest-job age, success rate, and duration per job type;
   extend the dashboard that already exists with alert thresholds. On shutdown,
   stop accepting new jobs, let in-flight work finish within a grace period,
   and return unfinished jobs to the queue.
7. **Verify the failure modes** - Run and paste: duplicate enqueue, fail-then-succeed, permanent failure into the
   DLQ, a deploy mid-job, and two concurrent runs of one periodic job.

## Verification

- [ ] Every job's schedule or trigger is listed, with its handler's expected
      runtime and timeout.
- [ ] Handlers are idempotent, and the duplicate-enqueue test was run and
      passed.
- [ ] Retries are bounded with backoff, and only on transient errors; permanent
      failures go straight to the dead-letter path.
- [ ] Shutdown drains in-flight jobs and returns anything unfinished rather
      than dropping it.
- [ ] Queue depth, age of the oldest job, success rate, and duration are all
      visible, with alert thresholds set.
- [ ] Every step 8 failure mode ran, with results pasted.

## Rules

- Never write a handler whose correctness depends on running exactly once.
  Assume at-least-once delivery and design for it.
- Never retry indefinitely, and never retry an error that is not transient.
- Never drop a job on shutdown. Return it or let it be redelivered.
- Never ship a queue without a way to see depth and oldest-job age.
- Never call it done until the duplicate-enqueue test runs green.
