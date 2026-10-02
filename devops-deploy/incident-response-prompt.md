# Reusable prompt: incident response

Copy-paste the block below into any AI coding agent to debug a live incident or
write a post-mortem - structured triage, root-cause analysis, and actionable
follow-ups, not blame.

Keywords: incident, outage, on call, severity, mitigation, postmortem, sev1

---

Help me debug this incident or write a post-mortem for
`[incident description / error / symptom]`. The goal: understand what happened,
fix it, prevent it from happening again, and document it honestly.

## Steps

1. **Triage** - What's broken, when did it start, what changed (deploys,
   config, traffic spikes), all users or a subset? Gather error logs, metrics
   dashboards, recent deploys, and the alerts that fired.
2. **Contain, then investigate** - Cut impact now: roll back the deploy, scale
   up, disable the feature, route traffic away. Then trace symptom to root
   cause through stack traces, code paths, database state, and external
   responses. Do not guess.
3. **Fix minimally, verify recovery** - Smallest fix for the root cause, not
   layered fixes. Confirm recovery on error rate, latency, and saturation, and
   check for cascading failures or data inconsistencies.
4. **Timeline, cause, and impact** - Reconstruct what happened, when, and in
   what order from alerts, deploys, and logs. Name the technical cause with
   code-level detail, not "a bug was introduced." Quantify users affected,
   duration, and data loss, then say specifically what failed in the system or
   process, systemic rather than personal.
5. **Action items** - Concrete, owned, with deadlines: code fixes, process
   changes, monitoring additions. Each one prevents a specific aspect of this
   incident from recurring.

## Verification

- [ ] Containment happened before investigation, and the impact reduction is
      stated.
- [ ] The root cause is specific and evidence-backed, or explicitly marked
      uncertain with the supporting evidence listed.
- [ ] Recovery is confirmed against error rate, latency, and saturation rather
      than assumed from a restart.
- [ ] The timeline is reconstructed from alerts, deploys, and logs, with times.
- [ ] Impact is quantified in users, duration, and data loss.
- [ ] Action items are assigned with owners and deadlines, and none of them is
      a bare instruction to add more tests.
- [ ] No individual is blamed; causes are systemic.

## Rules

- Never assign blame to individuals - focus on systemic causes and process
  improvements.
- Never write "add more tests" as an action item without specifying what tests
  and what they would catch.
- Never skip the containment step during a live incident to investigate root
  cause - reduce impact first.
- If the root cause is uncertain, say so and list what evidence supports each
  hypothesis.
