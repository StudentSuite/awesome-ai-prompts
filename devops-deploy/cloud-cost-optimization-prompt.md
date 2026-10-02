# Reusable prompt: cloud cost optimization

Copy-paste the block below into any AI coding agent to cut infrastructure spend
without breaking anything - ranked by real cost, rightsized from measured
utilization, with a before/after table you can check.

Keywords: cloud cost, rightsizing, idle resources, budget alert, storage lifecycle

---

Reduce the cloud bill for `[environment or account]` in this repository. The
rule: **measure first, change the biggest number, verify nothing broke**. A
saving you cannot account for is a saving you cannot claim.

## Steps

1. **Pull the real bill, then rank it** - Get cost by service, region, and tag
   for the current and previous period, and paste the breakdown. Sort by actual
   spend, not by suspicion, and for the top five say what it is, who owns it,
   and whether production needs it.
2. **Reduce what is running** - Hunt idle resources: unattached volumes and
   IPs, stopped-but-allocated instances, idle load balancers, unassociated
   snapshots, expired DNS records, idle replicas - stating each one's monthly
   cost only after verifying nothing references it. Then pull CPU, memory, and
   request counts for the last 30 days and size down to the measured high-water
   mark with headroom, naming the metric and percentile. Trust memory; CPU can
   be throttled and look low.
3. **Set lifecycle and commitments** - Move cold data to cheaper storage
   classes on an explicit schedule, expire logs and snapshots on a retention
   period, delete versions nobody restores. Compare on-demand against reserved
   or committed-use pricing for steady workloads, and name the break-even
   period.
4. **Alert, verify, report** - Set budget alerts at a threshold and a
   percentage of spend and name who gets paged. Then give a before/after table
   (old, new, monthly saving, risk taken), confirm the app still works after
   each change, and state which changes are reversible.

## Verification

- [ ] The real bill is pulled and broken down by service; offenders are ranked
      by actual spend.
- [ ] Every proposed saving carries the utilization or usage data behind it.
- [ ] Nothing was deleted without proving its reference count is zero.
- [ ] Each change and its monitoring change land together, not as separate
      untracked steps.
- [ ] The reported total is the sum of itemized, verified rows, in a before and
      after table.
- [ ] Any commitment term is shown against a baseline that justifies it.

## Rules

- Never propose a saving without the utilization or usage data behind it.
- Never delete a resource that anything references. Prove the reference count
  is zero first.
- Never change production and the monitoring in separate untracked steps. Every
  change needs a way to see it working.
- Never claim a total saving that is not the sum of itemized, verified rows.
- Never commit to a long contract term without showing the baseline that
  justifies it.
