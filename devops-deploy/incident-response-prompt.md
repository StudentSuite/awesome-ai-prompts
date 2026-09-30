# Reusable prompt: incident response

Copy-paste the block below into any AI coding agent to debug a live incident
or write a post-mortem - structured triage, root-cause analysis, and
actionable follow-ups, not blame.

Keywords: incident, outage, on call, severity, mitigation, postmortem, sev1

---

Help me debug this incident or write a post-mortem for `[incident description
/ error / symptom]`. The goal: understand what happened, fix it, prevent it
from happening again, and document it honestly.

## For live debugging

1. **Triage** - Establish the current state: What's broken? When did it start?
   What changed recently (deploys, config changes, traffic spikes)? Is it
   affecting all users or a subset? Gather the evidence: error logs, metrics
   dashboards, recent deployments, and alerts that fired.
2. **Contain** - What can be done right now to reduce impact? Roll back the
   last deploy, scale up, disable the broken feature, route traffic away.
   Do this first, then investigate root cause.
3. **Investigate** - Trace the failure from the symptom to the root cause:
   read the error stack trace, follow the code path, check the database
   state, verify external service responses. Use the repo's debugging tools
   and logs. Do not guess - gather evidence.
4. **Fix** - Apply the minimal fix that addresses the root cause. Verify the
   fix works by monitoring the metrics and logs after deployment. Do not
   layer fixes on top of fixes.
5. **Verify recovery** - Confirm the service is healthy: error rates dropped,
   latency normalized, and affected functionality works. Check for secondary
   issues (cascading failures, data inconsistencies).

## For post-mortem writing

1. **Timeline** - Reconstruct the timeline from alerts, deploys, and logs.
   What happened, when, and in what order.
2. **Root cause** - What was the underlying technical cause? Be specific:
   code-level detail, not "a bug was introduced."
3. **Impact** - Quantify: users affected, duration, data loss (if any),
   revenue impact (if applicable).
4. **What went well** - What detection, response, or mitigation worked?
   Preserve these.
5. **What went wrong** - What failed in the system or the process? Be
   specific and factual.
6. **Action items** - Concrete, assigned, with deadlines: code fixes,
   process changes, monitoring additions. Each action must prevent a
   specific aspect of this incident from recurring.

## Rules

- Never assign blame to individuals - focus on systemic causes and
  process improvements.
- Never write "add more tests" as an action item without specifying what
  tests and what they would catch.
- Never skip the containment step during a live incident to investigate
  root cause - reduce impact first.
- If the root cause is uncertain, say so and list what evidence supports
  each hypothesis.
