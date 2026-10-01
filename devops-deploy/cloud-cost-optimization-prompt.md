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

1. **Get the real bill** - Pull the current and previous period cost broken
   down by service, region, and tag. Establish the total and the period first;
   every later claim is a fraction of this number. Paste the breakdown.
2. **Rank offenders by cost** - Sort services by actual spend, not by how
   suspicious they look. For each of the top five, say what it is, who owns it,
   and whether it is required in production. A line item nobody can explain is
   a finding, not a saving yet.
3. **Find genuinely idle resources** - Look for unattached volumes and IPs,
   stopped-but-allocated instances, idle load balancers, unassociated
   snapshots and images, expired certificates and DNS records, and idle
   container replicas. For each candidate, state its monthly cost and whether
   anything still references it. Verify the reference check, do not infer it.
4. **Rightsize from measured utilization** - Pull CPU, memory, and request
   counts for the last 30 days. Size down to the measured high-water mark with
   headroom, and name the metric and percentile you used. Memory is usually the
   one to trust: CPU can be throttled and look low.
5. **Set storage lifecycle policies** - Move cold data to cheaper storage
   classes with an explicit transition schedule, expire logs and snapshots on a
   retention period, and delete versions nobody restores. State each object's
   retention requirement before moving it; deleting a backup that something
   still needs is an outage, not a saving.
6. **Right-size commitments** - Compare on-demand spend against reserved or
   committed-use pricing for steady workloads. Only commit where the baseline
   is visible in the utilization data and the commitment length fits the plan.
   Name the break-even period.
7. **Add budget alerts** - Set alerts at a threshold and a percentage of the
   current spend, and name who gets paged. An alert nobody receives is not a
   control. Note the per-service or per-tag granularity you can support.
8. **Verify and report** - Produce a before/after table with the old number, the
   new number, the monthly saving, and the risk taken. Confirm the application
   still works after each change, and state which changes are reversible.

## Rules

- Never propose a saving without the utilization or usage data behind it.
- Never delete a resource that anything references. Prove the reference count
  is zero first.
- Never change production and the monitoring in separate untracked steps. Every
  change needs a way to see it working.
- Never claim a total saving that is not the sum of itemized, verified rows.
- Never commit to a long contract term without showing the baseline that
  justifies it.

## Verification

Paste the cost breakdown, the ranked offender list with monthly amounts, the
utilization data behind each rightsizing, the before/after savings table, and
the confirmation that the service still works after each change. Sum the
itemized rows and show they equal the claimed total.
