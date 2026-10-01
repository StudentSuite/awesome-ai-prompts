# Reusable prompt: privacy and GDPR compliance review

Copy-paste the block below into any AI coding agent to run a privacy review
that ends in an ordered fix list, backed by the code that actually stores and
deletes the data.

Keywords: gdpr, data inventory, lawful basis, retention, subject rights

---

Review `[the product, service, or data flow]` in this repository for privacy
compliance. Ground every finding in a table, a migration, a queue consumer, or
a config file you can point to, and rank the fixes by risk.

## Steps

1. **Build the data inventory** - For every category of personal data
   collected, record what it is, the field or column holding it, the
   `file:line` or schema, the purpose, and the lawful basis claimed (consent,
   contract, legitimate interest, or obligation). A category with no lawful
   basis named is a finding, not a footnote.
2. **Trace storage and transit** - Map each item to where it lives: primary
   database, search index, cache, object storage, warehouse, log files, error
   trackers, analytics, and backups. Note encryption at rest and in transit and
   the region each store sits in. Data sitting in a log or a vendor tool is
   still processing.
3. **Name the retention period and its mechanism** - For each item, state the
   documented retention period and the code that enforces it: the scheduled
   job, TTL, partition drop, or soft-delete filter. "Kept for 30 days" with no
   mechanism behind it is an unbounded retention claim.
4. **Walk consent and withdrawal as a user would** - Find every consent
   capture point and the text shown there. Then trace withdrawal end to end:
   does undoing consent take as few steps as giving it, and does it stop
   collection and downstream processing, or only flip a stored flag while the
   data keeps flowing?
5. **Exercise the rights flows** - For export, deletion, and correction, name
   the endpoint or admin tool, walk the steps through the real code path, and
   record what happens to derived data, backups, and processor copies. State
   the completion time and who can trigger it. Untested flows are usually
   broken flows.
6. **List processors and their agreements** - Table every third party that
   touches personal data (hosting, email, payments, support, analytics, model
   providers, their sub-processors) with agreement status, data location, and
   whether a processing agreement and transfer mechanism are evidenced in the
   repo or the docs. Missing paperwork is itself the finding.
7. **Rank the minimization work** - List what is collected but not needed for
   the stated purpose, ordered by risk: highest sensitivity and widest blast
   radius first. For each, name the field to drop or coarsen and the consumer
   to delete, so the output is a backlog rather than a worry.

## Rules

- Cite evidence for every finding: a `file:line`, a config, a migration, or a
  document link. Write "unverified" where you could not check.
- Never accept a retention claim without the code path that enforces it.
- Never treat consent as collected without the capture point and the stored
  record it writes.
- Do not paste real personal data into the report; redact and cite locations.
- Separate what the regulation requires from what this product promises, and
  flag the gap between the two.

## Verification

Paste the data inventory table, the retention table with the enforcing
`file:line` for each item, the processor agreement table, and one rights
request walked end to end. List the ranked minimization backlog with the risk
that justifies each position.
