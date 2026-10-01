# Reusable prompt: ship a model like a service

Copy-paste the block below into any AI coding agent to take a trained model
from a notebook to a versioned, validated, monitored, and rollback-able service,
with stated latency targets and a rehearsed path back to the previous version.

Keywords: model deployment, model registry, inference api, drift, rollback

---

Deploy `[the model in this repo]` as a service. A notebook that runs is not a
deployment. The deliverable is a versioned artifact in a registry, an inference
endpoint that validates its input and output including a reject path, measured
latency and throughput under overload, drift monitoring with a retraining
trigger, and a rollback that has actually been exercised.

## Steps

1. **Package and version the artifact** - Export the trained weights plus
   everything needed to reproduce inference: preprocessing, label list or output
   head, code version, training data version, hyperparameter values. Store them
   as one immutable artifact with a content hash and a semantic version. The
   service must not depend on files in a notebook.
2. **Register it with its provenance** - One registry entry per version holding
   the artifact URI and hash, the training commit, the eval results, the feature
   schema version, the dependencies, and the owner. State who may promote a
   version to production. Every deploy references a registry version, never a
   loose path.
3. **Expose an inference API with contracts** - Define request and response
   schemas. Validate input at the edge: required fields present, types and
   ranges legal, unknown features rejected rather than silently dropped, batch
   shape and size bounded. Validate output: schema conformance, label in the
   known set, scores finite and in range. Version the contract.
4. **Build a real reject path** - Inputs that fail validation, fall outside the
   training distribution, or trip a size limit get a machine-readable error with
   a reason code and an HTTP status, not a stack trace and not a silent default
   prediction. Write tests for each reject branch and show what the caller sees.
5. **Set latency and throughput targets, then measure** - State p50, p95, and
   p99 latency targets, a throughput target in requests per second, and the
   replica count assumed. Add batching with a max batch size and a max wait
   time. Load test well past the target: report p50/p95/p99, error rate, and
   queue depth. Under overload, say what happens by design - shed load, degrade
   to a cheaper model, queue with a timeout, or return an error - then show that
   behavior under load, not just the happy-path number.
6. **Monitor drift and decide when to retrain** - Log inputs or a privacy-safe
   summary of them, predictions, and their distributions. Alert on feature
   drift, prediction distribution shift, and output-schema violations. Write the
   retraining trigger as a number with a threshold and an owner: a sustained
   PSI or KL shift on the primary score for N consecutive days opens a ticket.
   Backfill ground truth and track accuracy on a delay-appropriate window so
   quality loss is caught, not inferred.
7. **Roll out gradually and keep the previous version warm** - Ship shadow,
   then a small percentage, then full, with an automated halt on error rate,
   latency, or quality regression. Keep the previous version loadable and
   selectable by version id so rollback is a config change, not a rebuild.
8. **Rehearse the rollback** - In a non-production environment, roll back under
   load, run the contract tests against the previous version, and confirm the
   artifact, schema version, and configuration move together. Paste the version
   ids before and after, the test output, and the time the rollback took.

## Rules

- No deploy without a registry version, a validation contract, and a measured
  latency number under load.
- Fail loudly on invalid input; never invent a prediction to please a caller.
- Delayed-label monitoring is the backstop; drift alerts are early warnings.
- If you cannot state the latency target or the overload behavior, say the
  design is not ready to ship rather than estimating them.
- Keep the previous two versions loadable. One rollback path that was never
  tested is a page in an incident doc, not a safety net.

## Verification

Paste the registry entry, the load test table with p50/p95/p99 and error rate
under overload, one rejected request and the response it returned, and the
rehearsed rollback showing version ids and passing contract tests.
