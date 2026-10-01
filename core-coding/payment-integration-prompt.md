# Reusable prompt: payment integration

Copy-paste the block below into any AI coding agent to add payments to an
application with the discipline money demands: no raw card data, idempotent
mutations, verified webhooks, and a reconciliation job that finds money that
does not add up.

Keywords: payment, stripe, idempotency, webhook, reconciliation, refund, pci

---

Integrate payments for `[what: subscriptions / one-off checkout / marketplace
payouts]` into this repository. The rule: **the provider is the source of truth
and every webhook is untrusted input**. Your database is a cache of what the
provider already decided.

## Steps

1. **Keep card data out of your system** - Use the provider's hosted fields or
   client SDK so the primary account number never reaches your servers. Store
   only provider tokens or IDs plus a display-safe last4 and brand. Identify
   which provider feature keeps you out of PCI scope and note it; do not claim
   compliance you have not verified.
2. **Make every mutation idempotent** - Attach an idempotency key to every
   create, charge, and refund, derived from your own stable identifier (order
   ID, not a random UUID per attempt). A retry after a timeout must never
   produce a second charge. Record the key alongside the result so a duplicate
   submission returns the original outcome.
3. **Verify every webhook, then parse it** - Verify the signature against the
   raw request body before JSON parsing, and reject stale timestamps to block
   replay. Treat the body as untrusted: look the object up by ID and read its
   state from the provider rather than trusting status fields in the payload.
   Webhooks can arrive out of order, more than once, and hours later.
4. **Model the lifecycle as an explicit state machine** - Define the states
   (for example draft, pending, authorized, captured, failed, refunded,
   disputed) and the only legal transitions. Reject illegal transitions rather
   than letting an out-of-order webhook move a charge backwards. Persist every
   transition with a timestamp so the history is auditable.
5. **Treat local state as a cache** - Confirm the important states by fetching
   the object from the provider instead of inferring them from webhook order.
   Make the system correct when a webhook never arrives.
6. **Build reconciliation** - A scheduled job compares local payment records
   against the provider's balance transactions for the day and reports any
   mismatch by amount and reference. This is what catches a dropped webhook,
   a double charge, and a refund that never landed. Say what it does when it
   finds a discrepancy: alert, repair, or block.
7. **Cover refunds and disputes** - Refund through the state machine with a
   second idempotency key. Handle a dispute webhook as a distinct event with a
   deadline, not as a refund.
8. **Test the paths that actually happen** - In provider test mode, run and
   paste: success, declined card, insufficient funds, timeout then retry (prove
   one charge), duplicate webhook delivery, out-of-order webhooks, refund, and
   chargeback. Cover the async paths, not just the happy one.

## Rules

- Never accept or log a full card number, CVC, or bank password.
- Never treat a webhook payload as authoritative without a signature check and
  a provider lookup.
- Never allow a retry to create a second charge. If the flow lacks an
  idempotency key, it is not finished.
- Never let a state machine move backwards because of a late webhook.
- Never call a payment flow complete without the declined, refunded, and
  duplicate-delivery tests running green.

## Verification

Paste the state machine and its legal transitions, the reconciliation job
output for a day that matches, and the results of all eight test-mode cases.
Confirm the timeout-then-retry case produced exactly one charge, and name where
the idempotency key is stored.
