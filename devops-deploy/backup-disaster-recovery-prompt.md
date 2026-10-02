# Reusable prompt: backup & disaster recovery

Copy-paste the block below into any AI coding agent to build backups and a DR
plan that have actually been restored - untested backups are Schrödinger's
backups.

Backup configuration as code, a restore runbook with verified commands, and a
table of stores with their measured RPO/RTO.

Keywords: backup, disaster recovery, restore, rpo, rto, recovery drill, snapshots

---

Set up backups and disaster recovery for this system. The deliverable is not
backup jobs - it is demonstrated restores, documented recovery steps, and known
RTO/RPO numbers.

## Steps

1. **Classify the data** - Inventory data stores and ask per store: how much
   data loss is tolerable (sets RPO) and how long may recovery take (sets RTO)?
   Backing up everything identically is rarely the answer; tier by criticality.
2. **Design the backup scheme** - Right tool per store (managed snapshots,
   dump/restore, replication with point-in-time recovery); 3-2-1 rule (three
   copies, two media, one offsite or off-account); encryption at rest;
   retention policy with legal considerations noted. Access-control the backups
   too - they contain everything.
3. **Automate and monitor** - Scheduled jobs with failure alerting (a backup
   job that fails silently is worse than none - it lies), success/failure
   recorded, and restore tooling versioned alongside the app so it never drifts
   out of compatibility.
4. **Prove restores work** - Restore into a scratch environment from the real
   backups: a full restore, plus point-in-time if supported. Time it. Verify
   integrity (row counts, spot-checked records, app smoke tests against
   restored data). Document the exact commands that worked.
5. **Write the DR runbook** - Scenario-driven: "database region lost", "bad
   migration shipped", "account compromised". Per scenario: detection, decision
   tree, recovery steps referencing the tested commands, and communication
   owner.
6. **Schedule drills** - Restore tests on a calendar (quarterly is common),
   re-run after major schema/architecture changes, and update RTO/RPO numbers
   from measured results rather than hopes.

## Verification

- [ ] Every store is classified by recovery point and recovery time objective,
      with the tool chosen per store.
- [ ] Backup jobs are scheduled with failure alerting, so a silent backup
      counts as a failure.
- [ ] A real restore was performed into a scratch environment, with the output
      shown, and never against production data in place.
- [ ] The runbook covers each named scenario, including total region loss, with
      the exact restore commands.
- [ ] Restore drills are on a calendar with an owner, not left to the next
      incident.

## Rules

- A backup that has never been restored is a hypothesis, not a capability -
  prove at least one restore before calling this done.
- Alerting on backup failure is mandatory; silent failures don't count.
- Never test restores against production data in place; use scratch
  environments.
