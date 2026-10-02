# Reusable prompt: chaos & resilience testing

Copy-paste the block below into any AI coding agent to test how the system
behaves when dependencies fail - and to close the gaps found, with evidence.

Keywords: chaos engineering, resilience, fault injection, failure testing, degrade gracefully

---

Test this system's resilience by injecting failures. The question is never
"does it work?" but "what happens when X is slow, down, or full?" - and the
answer must come from experiments, not confidence.

## Steps

1. **Build the failure map** - List external dependencies and failure modes:
   downstream APIs (timeout, 500s, slow responses), the database (connection
   exhaustion, lock timeouts), queues (backlog, poison messages), disk/network
   (full, partitioned), clock skew. Note current handling for each.
2. **Form hypotheses** - For each dependency, predict the behavior when it
   fails: what does the user see? how often does it retry? does the process
   crash, hang, or degrade? Write predictions down before testing.
3. **Inject safely** - Experiment in a staging-like environment first; use the
   least invasive tool available (fault-injection proxies, network shaping,
   kill switches, resource limits). Production experiments only with explicit
   approval, capped blast radius, and an abort plan.
4. **Observe honestly** - Compare observed behavior to hypotheses. Classic
   findings: missing timeouts (hangs forever), retry storms amplifying outages,
   cascading failure from connection pool exhaustion, silent data loss,
   alerting that never fires.
5. **Fix what broke** - Implement the minimal resilience fixes: explicit
   timeouts everywhere, bounded retries with backoff and jitter, circuit
   breakers on repeat offenders, bulkheads around shared resources, graceful
   degradation paths (cache fallback, queue-and-resume).
6. **Re-run and codify** - Repeat injections post-fix and show the difference.
   Turn surviving experiments into automated tests or CI jobs where practical,
   and document the system's known failure behaviors.

## Verification

- [ ] The failure map lists every external dependency and its failure mode.
- [ ] Each hypothesis was written down before the injection, then compared with
      observed behavior.
- [ ] Injection ran in a staging-like environment first, with destructive work
      explicitly approved.
- [ ] Every infinite or absent timeout found is flagged as a defect.
- [ ] Post-fix re-runs are shown, and the resilience checks are codified as
      repeatable tests.
- [ ] The report states what was not tested.

## Rules

- Never run destructive experiments against production data without explicit
  sign-off and a rollback plan.
- A timeout default of "none/infinite" is a defect - flag every one found.
- Report what was tested and what wasn't; untested resilience is unknown, not
  proven.
