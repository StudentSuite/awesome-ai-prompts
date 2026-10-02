# Reusable prompt: capacity planning

Copy-paste the block below into any AI coding agent to find out when the system
will hit a wall, and how long it takes to fix - so upgrades are scheduled
rather than discovered at 3am.

Keywords: capacity planning, headroom, scaling, limits, forecast, alerts

---

Plan capacity for `[system or service]` in this repository. The rule: **name
the wall, the date you will hit it, and the lead time you need**. A capacity
plan is a date and an owner, not a utilization graph.

## Steps

1. **Measure capacity** - Find bottlenecks (CPU, memory, disk I/O, network,
   database connections, queue depth, rate limits, third-party quotas). Measure
   headroom per limit from observed peak usage, not averages. Cite the
   enforcement point for each.
2. **Project demand** - Pick one leading product metric (DAU/MAU, requests/sec,
   jobs/hour), project 3 and 6 months, show arithmetic, and state assumptions.
3. **Identify walls** - For each bottleneck compute the hit date, work to delay
   it, and cost/complexity. Sequence by hit date.
4. **Set alerts and unknowns** - Put every alert ahead of its wall. List
   assumptions that would invalidate the plan and what triggers a re-plan.

## Verification

- [ ] Every bottleneck cites its enforcement point in config, quota, or code,
      not an assumed number.
- [ ] Current headroom per limit is measured from observed peak usage, not
      averaged usage.
- [ ] Each projection names the product metric that produced it, with the
      arithmetic shown.
- [ ] The work is sequenced by the date each wall is hit, not by team
      preference or effort.
- [ ] Every alert threshold sits meaningfully ahead of its wall, not at the
      moment of failure.
- [ ] The assumptions that would invalidate the plan are listed.

## Rules

- Never forecast from average usage when the failure mode is a peak.
- Never claim a limit you cannot cite the enforcement point for.
- Never schedule the work by team preference; schedule it by the date the wall
  arrives.
- Never set an alert that fires at the same moment as the outage.
- Never present a date without naming the product metric that produced it.
