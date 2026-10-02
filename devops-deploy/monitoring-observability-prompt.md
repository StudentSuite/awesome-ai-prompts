# Reusable prompt: monitoring and observability

Copy-paste the block below into any AI coding agent to set up logging, metrics,
and alerting - actionable dashboards and alerts, not noisy dashboards nobody
checks.

Keywords: monitoring, observability, metrics, logs, tracing, alerting, slo

---

Set up monitoring and observability for `[service / application / endpoint]`.
The goal: when something goes wrong, you know what, where, and why within
minutes, not hours of log-diving.

## Steps

1. **Map the system first** - Read the code for critical paths, external
   dependencies, error conditions, and performance-sensitive operations. Define
   what "healthy" looks like before what "broken" looks like.
2. **Add structured logging** - Emit JSON at request entry/exit, external
   calls, database queries, error paths, and business-critical operations. Use
   the repo's consistent levels and correlation IDs.
3. **Instrument the four signals** - Latency (p50, p95, p99), traffic (requests
   per second), errors (rate and types), and saturation (CPU, memory,
   connection pool usage), per critical path, on the repo's existing metrics
   library.
4. **Build incident dashboards** - Answer the on-call questions: is the service
   healthy, what is the error rate, which endpoints are slow, are dependencies
   responding. One service per dashboard, key signals at a glance.
5. **Configure and verify alerts** - Alert only on actionable conditions: error
   rate above threshold, latency exceeding SLA, dependency unreachable, disk or
   memory critical. Each alert carries a severity, a runbook link, and an
   owning team. Then trigger or simulate a real failure and show the log line,
   the metric, the dashboard, and the alert.

## Verification

- [ ] Existing observability tooling was extended rather than replaced.
- [ ] Structured JSON logging exists at the critical points, with no logging
      added to a hot loop.
- [ ] The four golden signals are instrumented per critical path, not globally.
- [ ] Every alert states the action it expects, and no alert fires on a
      condition nobody would act on.
- [ ] A real or simulated failure was triggered and the resulting log line,
      metric, and alert were shown.
- [ ] Dashboards answer the named on-call questions rather than just displaying
      available data.

## Rules

- Never add logging in hot loops or high-frequency paths without considering
  the performance impact.
- Never create alerts that nobody should act on - if you can't define the
  response action, don't alert on it.
- Never use plain text logging when structured logging is available in the
  stack.
- If the repo already has observability tooling, extend it rather than
  introducing a parallel system.
