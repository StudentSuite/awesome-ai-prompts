# Reusable prompt: privacy and GDPR compliance review [spec]

Copy-paste the block below into any AI coding agent to run a privacy review
grounded in the code that stores and deletes personal data. The heavy format
applies when a wrong answer ships a compliance gap: it ends with a risk-ranked
minimization backlog, not a policy summary.

Keywords: gdpr, data inventory, lawful basis, retention, subject rights

---

Review `[the product, service, or data flow]` in this repository for privacy
compliance. Ground every finding in a table, a migration, a queue consumer, or
a config file you can point to, and rank the fixes by risk. This is a code
review, not legal advice.

## Define the scope first

Decide these yourself, not by asking the user.

1. **Surface and data** - The product, service, or data flow under review and
   the personal data it touches. Where the repo holds several, pick the
   highest-risk one and name the rest out of scope.
2. **Jurisdictions** - Which privacy regimes apply to the users in scope and
   which do not. Name the ones you cannot check against the code.
3. **Inputs** - Where the facts come from: schema, migrations, queue
   consumers, scheduled jobs, configs, third-party docs, and write endpoints.
4. **Outputs** - The data inventory, retention table, consent and rights
   walkthroughs, processor list, and ranked minimization backlog.
5. **Out of scope** - No compliance certification, no drafted policy, no
   lawful basis the code and docs do not evidence. This is not legal advice;
   say so in the report.

## What to produce

1. **Data inventory and storage map** - For every category of personal data:
   what it is, the field or column holding it, the `file:line`, the purpose,
   the lawful basis claimed, and where it lives (database, search index, cache,
   object storage, warehouse, logs, error trackers, analytics, backups) with
   encryption at rest and in transit and the region. Evidence: a matrix. No
   basis named is a finding; a log or vendor tool is still processing.
2. **Retention table with mechanisms** - For each item, the documented period
   and the code that enforces it: the scheduled job, TTL, partition drop, or
   soft-delete filter. Evidence: a table of item | period | enforcing
   `file:line`. "Kept for 30 days" with no mechanism is an unbounded claim.
3. **Consent and withdrawal walkthrough** - Every consent capture point and the
   text shown there, then withdrawal traced end to end. Evidence: a numbered
   walk with a `file:line` per step: does undoing take as few steps as giving,
   and does it stop collection and downstream processing or only flip a flag?
4. **User-rights flows** - Export, deletion, and correction: the endpoint
   or admin tool, the code path, what happens to derived data, backups, and
   processor copies. Evidence: one request walked end to end with
   `file:line` hops, plus derived data | survives? | where.
5. **Processor list** - Every third party touching personal data (hosting,
   email, payments, support, analytics, model providers, sub-processors) with
   agreement status, data location, and whether a processing agreement and
   transfer mechanism is evidenced. Missing paperwork is itself the finding.
6. **Ranked minimization backlog** - What is collected but not needed for the
   stated purpose, ordered by risk: highest sensitivity and widest blast radius
   first. Evidence: field to drop or coarsen | consumer to delete | the risk
   that justifies its rank.

## Method

Run the phases in order. Each has an exit condition.

1. **Read the data model first** - Start with schema, migrations, and ORM
   models to learn what fields exist before reading how they are used. Exit: a
   field list with a source `file:line` for each.
2. **Trace collection to storage** - Follow each collection point's write path
   to every store it reaches, including logs, queues, and third parties. Exit:
   the storage matrix resolves for every inventoried item.
3. **Prove retention** - Open the scheduled job, TTL, or filter behind each
   claim and record the line. Exit: every row has an enforcing `file:line` or
   is marked unverified.
4. **Walk consent and withdrawal** - Step through the real capture and
   withdrawal paths as a user, recording each hop. Exit: both walks complete,
   or the missing half is a named finding.
5. **Exercise the rights flows** - Trigger export, deletion, and correction in
   a non-production environment. Exit: a deletion is confirmed to remove the
   record, and every survivor is listed with a reason.
6. **Build the processor list** - Enumerate every integration that receives
   personal data and check each agreement against the repo or linked docs.
   Exit: every processor has an agreement status and a data location.
7. **Rank the backlog** - Order the minimization work by risk, attaching each
   item to a `file:line` and a consumer. Exit: a work plan, not a worry.

## Verification

Before reporting the review complete, confirm each of these:

- [ ] Scope names the surface, the jurisdictions in play, the inputs, the
      outputs, and an explicit statement that this is not legal advice.
- [ ] The inventory gives every category's field or column `file:line`, purpose,
      lawful basis, and every store it reaches with encryption and region,
      flagging a category that names no basis.
- [ ] Every retention period has an enforcing `file:line`, or is marked
      unverified as an unbounded retention finding.
- [ ] The withdrawal walkthrough states whether it stops processing or only
      flips a flag, with the `file:line` that proves it.
- [ ] The deletion flow is walked end to end and the report names what remains
      in backups, derived stores, and processor copies.
- [ ] Every third party touching personal data is listed with agreement status
      and data location, and missing paperwork is flagged.
- [ ] The minimization backlog is risk-ranked, each item naming the field to
      drop or coarsen and the consumer to delete.
- [ ] No real personal data appears in the report; rows are redacted and cited
      by location.

## Rules

- Never present this review as legal advice or a certification of compliance.
- Never accept a retention claim without the code path that enforces it, and
  never treat consent as collected without its capture point and stored record.
- Never assume withdrawal stops processing; verify it and name what keeps
  flowing if it does not.
- Never call a rights flow implemented without walking it end to end, including
  backups and processor copies.
- Never paste real personal data into the report; redact it and cite location.
- Separate what the regulation requires from what the product promises, and cite
  evidence for every finding; write "unverified" where you could not check.
