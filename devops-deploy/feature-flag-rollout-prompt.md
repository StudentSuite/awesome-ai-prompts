# Reusable prompt: feature flags & progressive rollout

Copy-paste the block below into any AI coding agent to ship a risky change
behind a flag with progressive rollout, an instant kill switch, and a cleanup
plan.

Keywords: feature flag, rollout, progressive delivery, canary, percentage, toggle, dark launch

---

Ship the requested feature behind a feature flag with a progressive rollout
plan. Flags exist to decouple deploy from release: the code ships dark, enables
gradually, and can be killed in seconds without a redeploy.

## Steps

1. **Decide the flag's shape** - Boolean, percentage, or per-segment? Who does
   it target (internal users, beta cohort, percent of traffic)? Where does flag
   state live (platform SDK, DB-backed, config service)? Prefer the repo's
   existing flag system if one exists.
2. **Wrap at the right granularity** - Flag the capability, not every line: one
   decision point at the entry to the new path, both branches complete and
   shippable. The old path stays intact and tested until cutover.
3. **Keep both paths healthy** - Tests cover flag-on AND flag-off; typecheck
   doesn't rot the dormant branch; telemetry identifies which variant served
   each request.
4. **Plan the rollout ladder** - Internal, then 1%, 10%, 50%, 100% - with
   explicit go/no-go metrics at each step (error rate, latency, conversion,
   support tickets) and a named owner. Define kill criteria before enabling
   anything.
5. **Instrument the switch** - Enabling/disabling must not require a deploy,
   must take effect within seconds, and must be audited (who flipped what,
   when). Test the kill switch by flipping it off mid-experiment.
6. **Clean up on a schedule** - Once stable, remove the flag and the dead
   branch within an agreed window; stale flags compound into unreadable code.
   Record the removal task immediately, not "later".

## Verification

- [ ] The flag wraps a capability rather than being scattered through
      individual lines.
- [ ] Both flag-on and flag-off paths pass CI, and both are typechecked and
      covered by tests.
- [ ] The rollout ladder names the stage, the gate metric, and the pause
      between each step.
- [ ] Toggling the flag requires no deploy, and both states are observable.
- [ ] A kill criterion and a named owner are documented, and a cleanup date is
      set for the flag's removal.

## Rules

- No flag without a documented kill criterion and owner.
- Flag-on and flag-off must both pass CI - a broken dormant branch is a live
  grenade.
- Schema changes behind flags must stay backward-compatible with both states,
  since rollback can leave mixed data.
