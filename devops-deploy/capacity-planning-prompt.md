# Reusable prompt: capacity planning

Copy-paste the block below into any AI coding agent to find out when the system
will hit a wall, and how long it takes to fix - so upgrades are scheduled rather
than discovered at 3am.

Keywords: capacity planning, headroom, scaling, limits, forecast, alerts

---

Plan capacity for `[system or service]` in this repository. The rule: **name the
wall, the date you will hit it, and the lead time you need**. A capacity plan is
a date and an owner, not a utilization graph.

## Steps

1. **Enumerate the limits that actually bind** - For each component list the
   hard ceiling and where it is enforced: application instance CPU and memory,
   container limits, max database connections and its pool size, max queue
   throughput, storage capacity, third-party rate limits and quotas, and
   licensed seats. A limit you cannot cite a number for is a limit you have not
   investigated.
2. **Measure current headroom per bottleneck** - For each limit, record the
   measured value, the ceiling, and the peak (not the average) over a period
   long enough to include a real peak. Compute headroom as a ratio and name the
   growth it represents in the units that actually move (requests per second,
   concurrent sessions, rows per day).
3. **Tie growth to a product metric** - Ask which product number drives the
   load: registered users, active sessions, jobs per day, GB stored. Use the
   product forecast, and state it. Growth per user is often the honest unit:
   "10k users" means nothing until you say what one user does to the system.
4. **Project the date you hit each wall** - For each bottleneck, compute when
   measured usage plus growth reaches the ceiling. Give a date per component and
   the earliest date overall, which is the one that matters. If the forecast
   input is missing, say so and give the date as a function of the unknown.
5. **List the scaling options with cost and lead time** - For each bottleneck,
   the realistic options: vertical resize, horizontal scale out, a caching or
   query fix that removes load, splitting a hot path, raising a quota, or
   sharding. For each, state the cost per month, the engineering lead time, and
   the maximum headroom it buys. Note which options are reversible.
6. **Order by date, not by effort** - Sequence the work so the earliest wall is
   addressed first, and note any prerequisite (a migration before the config
   change that uses it).
7. **Set alerts ahead of the wall** - For each metric, set a warning threshold
   that fires with time to act, not one that fires when the outage starts.
   State the threshold as a percentage of the ceiling and the lead time it
   gives. Name who is paged.
8. **Say what would invalidate the plan** - List the assumptions: forecast
   accuracy, seasonal peaks, a feature that changes load shape, a dependency
   outage that shifts traffic. Give each a review trigger.

## Rules

- Never forecast from average usage when the failure mode is a peak.
- Never claim a limit you cannot cite the enforcement point for.
- Never schedule the work by team preference; schedule it by the date the wall
  arrives.
- Never set an alert that fires at the same moment as the outage.
- Never present a date without naming the product metric that produced it.

## Verification

Paste the limits table with enforcement points, the headroom table with measured
peaks, the forecast metric, the earliest projected wall date, the ranked
options with cost and lead time, and the alert thresholds. Confirm each alert
threshold leaves the stated lead time before its ceiling.
