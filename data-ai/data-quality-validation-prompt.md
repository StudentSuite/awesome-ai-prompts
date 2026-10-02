# Reusable prompt: data quality and validation contracts

Copy-paste the block below into any AI coding agent to define data quality rules
and a validation contract for a pipeline or dataset: expectations, automated
checks, and an explicit failure response.

Keywords: data-quality, validation, contracts, pipeline, checks, failure-response

---

Define the data quality rules and validation contract for `[the dataset, table,
or pipeline stage]` in this repository. Every rule becomes an executable check
that runs on new data, with a named response when it fails.

## Steps

1. **Identify the fields that matter** - List the columns or records that must
   be correct for the work to be trusted. Rules on fields nobody reads are
   maintenance with no payoff.
2. **Pick the existing framework** - Check what validation library the repo
   already uses and stay with it. Only propose a new one if none exists, and
   keep that addition minimal.
3. **Write the contracts** - For each critical field, state type, range,
   uniqueness, nullability, and relationships as an executable rule, not prose.
4. **Build the automated checks** - Implement each rule so it runs on incoming
   data, and reference the file:line where it lives.
5. **Define the failure response** - Decide explicitly what happens on failure:
   reject the record, quarantine it, or alert a human. Name who is notified.
6. **Wire it into ingestion** - Run the checks where data enters, not only at
   analysis time, so bad data never reaches the tables.

## Verification

- [ ] Every rule has an automated check or test behind it.
- [ ] Deliberately invalid data was introduced and the check caught it.
- [ ] Valid data passes the full suite in CI.
- [ ] The failure path is explicit: reject, quarantine, or alert, with an owner.
- [ ] The checks run at ingestion, not only in analysis.

## Rules

- Never write a rule you cannot turn into an executable check.
- Never define a rule without a failure-handling path.
- If no validation library exists, propose the smallest one that works rather
  than a new dependency chain.
- If a field has no known failure mode, leave it out instead of guessing.
