# Reusable prompt: ship a model like a service [spec]

Copy-paste the block below into any AI coding agent to take a trained model
from a notebook to a versioned, validated, monitored, and rollback-able
service. Use the heavy format here: an unvalidated endpoint or an untested
rollback is expensive the moment real traffic arrives.

Keywords: model deployment, model registry, inference api, drift, rollback

---

Deploy `[the model in this repo]` as a service. A notebook that runs is not a
deployment: the deliverable is a versioned registry artifact, an inference API
that validates input and output with an explicit reject path, a stated
overload behavior, latency and throughput measured under load, drift
monitoring with a named retraining trigger, and an exercised rollback.

## Define the scope first

1. **The model** - What it predicts, its input features and output shape, the
   training data version, and the framework and runtime it needs.
2. **The serving environment** - Where it runs (container, managed endpoint,
   edge), its CPU or GPU and memory limits, the caller path, and its owner.
3. **Targets** - p50, p95, and p99 latency targets, a throughput target in
   requests per second, and the replica count assumed. No replica, no target.
4. **Out of scope** - Training, tuning, feature-store changes, and any
   retraining run. This deploys an existing model; it does not improve it.

Treat each as a decision you can revise, not a question for the user.

## What to produce

1. **Immutable model artifact** - Weights plus everything inference needs
   (preprocessing, label list, code and data versions, hyperparameters) as one
   immutable artifact with a content hash and a semantic version.
   Evidence: the URI and hash, and no notebook files read at runtime.
2. **Registry entry** - One entry per version: artifact URI and hash, training
   commit, eval results, feature-schema version, dependencies, and owner.
   Evidence: the record plus the rule for who may promote a version. Every
   deploy references a registry version, never a loose path.
3. **Inference API contract** - Versioned request and response schemas. Input
   validation rejects missing fields, illegal types and ranges, unknown
   features, and out-of-bounds batches; output validation enforces schema,
   known labels, and finite in-range scores. Evidence: schema plus tests.
4. **Explicit reject path** - Each rejection returns a machine-readable reason
   code and an HTTP status, never a stack trace and never a silent default
   prediction. Evidence: a real rejected request and its response.
5. **Stated overload behavior** - Batching with a max batch size and wait time,
   bounded queueing, shedding, degrading to a cheaper model, or failing.
   Evidence: the policy in config plus a run where it fires.
6. **Measured latency and throughput** - Load test well past the target.
   Evidence: p50/p95/p99, error rate, queue depth under target and overload.
7. **Drift monitoring and retraining trigger** - Logged inputs or a
   privacy-safe summary, predictions, and distributions, alerting on feature
   drift, prediction shift, and schema violations. The trigger is a number, a
   threshold, and an owner: a sustained PSI or KL shift on the primary score
   for N consecutive days opens a ticket. Backfill ground truth and track
   accuracy on a delay-appropriate window.
8. **Rehearsed rollback** - In non-production, roll back under load, run the
   contract tests against the previous version, and confirm the artifact,
   schema version, and config move together. Evidence: version ids before and
   after, the test output, and the elapsed time.

## Method

Run the phases in order; measure before you optimize.

1. **Baseline before changing anything** - Measure the current path for
   p50/p95/p99, throughput, and error rate; if none exists, record zero.
   Exit: a baseline number or an explicit "none".
2. **Package and hash the artifact** - Export weights and inference code,
   version them, push to the registry. Exit: it starts from the URI alone.
3. **Contracts before the handler** - Publish the schemas, then build
   validation and the reject path. Exit: each branch has a test.
4. **Measure under load, then set the overload policy** - Load test past the
   target, then set the policy from the numbers. Exit: a load-test table and
   a policy that fires.
5. **Wire monitoring and the trigger** - Emit the logged signals and alert
   thresholds, owner named. Exit: the trigger is a number, not a feeling.
6. **Rehearse the rollback and record it** - Roll back under load in
   non-production, run the contract tests against the previous version, and
   capture version ids and timing. Exit: exercised, not described.
7. **Ship gradually with an automated halt** - Shadow, then a small
   percentage, then full, halting on error rate, latency, or quality
   regression. Exit: the promotion and halt rules are configured and cited.

## Verification

Before declaring the deployment complete, confirm each of these:

- [ ] The artifact is immutable with a content hash and semantic version, and
      every deploy references a registry version rather than a loose path;
      inference starts from the URI with no notebook files.
- [ ] Input validation rejects missing fields, illegal types, unknown
      features, and oversized batches, each with a test and a reason code.
- [ ] Output validation enforces schema, known labels, and finite in-range
      scores.
- [ ] A rejected request returns a machine-readable error and status,
      demonstrated by the captured response.
- [ ] Latency and throughput are measured under load and reported as
      p50/p95/p99, error rate, and queue depth against the stated targets.
- [ ] The overload behavior is stated and was observed firing in a load run.
- [ ] Drift monitoring is live, and the retraining trigger is a number with a
      threshold and a named owner.
- [ ] The rollback was actually exercised, with version ids before and after,
      and contract tests pass against current and rolled-back versions.
- [ ] The previous two versions remain loadable and selectable by version id.

## Rules

- Never deploy without a registry version, a validation contract, and a
  measured latency number under load.
- Never invent a prediction to please a caller; fail loudly on invalid input.
- Never call the overload behavior designed until it has been seen under
  load.
- Never describe a rollback you have not run; an untested path is not a safety
  net.
- Never treat drift alerts as the backstop; delayed-label accuracy is.
- Never keep only one version loadable; keep the previous two.
