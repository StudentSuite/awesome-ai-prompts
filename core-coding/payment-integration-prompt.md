# Reusable prompt: payment integration [spec]

Copy-paste the block below into any AI coding agent to add payments to an
application. Use this spec when money moves: failure is expensive and every
claim about a charge must be provable from a run log or provider record.

Keywords: payment, idempotency, webhook, reconciliation, pci scope, refund

---

Integrate payments for `[what: subscriptions / one-off checkout / marketplace
payouts]` into this repository. The rule: **the provider is the source of
truth and every webhook is untrusted input**. Your database is a cache of what
the provider already decided. Work only after scope is fixed.

## Define the scope first

State each decision below before any code; revise it, do not ask the user.

1. **Provider and environment** - Name the provider, whether this run targets
   test or live mode, and where credentials come from. No live keys here.
2. **What money flows** - One-off, subscription, or marketplace payout; who
   pays whom, when the charge is created, and what a refund or dispute does to
   it. Name the currency and the smallest unit used to represent amounts.
3. **Regions, currencies, and tax** - Which countries and currencies are
   supported, whether listed prices include tax, how rounding is handled, and
   who computes tax. Unstated tax behavior is a correctness bug.
4. **Out of scope** - List what this pass does not build (invoicing, dunning
   email, tax filing) and any money path excluded from the state machine.

## What to produce

1. **PCI-scope decision** - A one-page decision record naming the provider
   feature (hosted fields, client SDK, or tokenization) that keeps the primary
   account number off your servers, plus the data you may store (provider
   token, last4, brand). Cite the file:line that uses it; do not claim
   compliance you have not verified.
2. **Payment state machine** - The full set of states (for example draft,
   pending, authorized, captured, failed, refunded, disputed) and a matrix of
   legal transitions, each with the event that triggers it. Illegal
   transitions are rejected, never applied.
3. **Idempotency-key store** - The schema that records the key, the request
   fingerprint, and the stored response, plus the file:line where each create,
   charge, or refund reads it before acting. Keys derive from a stable
   business identifier, not a fresh random value per attempt.
4. **Webhook handler** - The code path that verifies the signature against the
   raw body before parsing, rejects stale timestamps, dedupes by event ID, and
   refetches the object by ID from the provider. Deliver a run log of replayed
   deliveries.
5. **Reconciliation job spec and output** - A scheduled job that compares local
   records against the provider's balance transactions for a day and reports
   mismatches by amount and reference. Deliver its run log for a matched day
   and for an injected mismatch, and state whether it alerts, repairs, or
   blocks.
6. **Test-mode evidence matrix** - A table of every Verification case with the
   observed result, provider object ID, and the log line that proves it.

## Method

Run the phases in order. Each has an exit condition; none may be skipped.

1. **Baseline the current money path** - Inventory existing payment code,
   keys, webhook endpoints, and manual steps, and record what works before
   changing it. Exit: a written inventory with file:line references.
2. **Fix scope and contracts** - Lock the decisions above and write the state
   machine and transition matrix before implementing. Exit: the matrix exists
   and every illegal transition has a defined rejection.
3. **Persist and enforce state first** - Store charges and every transition
   with a timestamp, and reject any event that would move a charge backwards.
   Exit: an out-of-order replay leaves state unchanged, proven by a log.
4. **Add idempotency** - Route every mutating call through the key store and
   return the stored response on a duplicate key. Exit: a resubmitted request
   returns the original result and creates no second object.
5. **Verify webhooks before trusting them** - Implement signature
   verification, a timestamp window, and event-ID dedupe, then read the
   object's state from the provider instead of the payload. Exit: replayed and
   out-of-order deliveries are handled correctly and logged.
6. **Build reconciliation and run it** - Implement the daily job and run it
   against a matched day and an injected mismatch. Exit: both run logs are
   captured and the mismatch is named by amount and reference.
7. **Run the full test-mode matrix** - Execute every case in Verification in
   the provider's test mode and record results. Exit: the matrix is complete,
   including exactly one charge for the retry case.

## Verification

Run every case in provider test mode and attach its log. Confirm each box:

- [ ] A success charge reaches a captured state by legal transitions only.
- [ ] A declined card leaves the charge failed with no captured funds, and the
      decline reason is recorded.
- [ ] A refund moves the charge to refunded through the state machine using
      its own idempotency key.
- [ ] A dispute webhook is handled as a distinct event with a deadline, not
      treated as a refund.
- [ ] A duplicate webhook delivery is deduped by event ID and changes state
      exactly once.
- [ ] Out-of-order webhooks are applied or rejected so the charge never moves
      backwards.
- [ ] A timeout then retry produces exactly one charge, proven by a single
      provider object ID across both attempts.
- [ ] Reconciliation for a matched day shows zero mismatches, and an injected
      mismatch is reported by amount and reference.
- [ ] The idempotency key store location is named, and a duplicate submission
      returns the original outcome.

## Rules

- Never accept, store, or log a full card number, CVC, or bank password.
- Never treat a webhook payload as authoritative without a signature check
  against the raw body and a provider lookup.
- Never allow a retry to create a second charge; a flow without an idempotency
  key is unfinished.
- Never let the state machine move backwards because of a late or duplicated
  webhook.
- Never ship a payment flow without the declined, refunded, dispute, duplicate,
  out-of-order, and timeout-then-retry cases running green.
- Never claim reconciliation, PCI scope, or one-charge behavior without the
  run log or provider object ID that proves it.
