# Reusable prompt: load testing

Copy-paste the block below into any AI coding agent to design and run load
tests with measurable thresholds and reproducible results, not a one-off
"it felt fast" test.

Keywords: load testing, stress test, throughput, capacity, latency under load, benchmark

---

Design and run load tests for `[endpoint / service / workflow]` in this
repository. The goal: measurable performance under load with clear pass/fail
thresholds, not just "it didn't crash."

## Steps

1. **Identify what to test** - Read the code to find the critical paths that
   need load testing: high-traffic endpoints, resource-intensive operations,
   database-heavy queries, or integrations with external services. Prioritize
   by business impact and expected traffic.
2. **Define realistic scenarios** - Model real user behavior: the mix of
   requests (read vs write), think time between requests, authentication
   patterns, and data volume. Use realistic payloads, not minimal test data.
   Consider both normal load and peak load scenarios.
3. **Choose the tool** - Use the repo's existing load testing tooling if it
   exists (k6, locust, Apache Bench, wrk, artillery). If none exists, pick
   the standard tool for the stack and set it up.
4. **Set thresholds** - Define measurable pass/fail criteria before running:
   - Response time: p50, p95, p99 latencies under load
   - Throughput: requests per second sustained
   - Error rate: maximum acceptable percentage (e.g. < 0.1%)
   - Resource usage: CPU, memory, connection pool limits
5. **Run the tests** - Execute against a staging or local environment that
   mirrors production. Run warm-up iterations first. Capture and save the
   full results with timestamps.
6. **Analyze and report** - Compare results against thresholds. Identify
   bottlenecks: database queries, connection pool exhaustion, memory leaks,
   or external service latency. Provide before/after numbers if making
   optimization changes.

## Rules

- Never run load tests against production without explicit approval and a
  maintenance window.
- Never report results without thresholds - "it handled 1000 rps" means
  nothing without knowing if that's enough.
- Never use toy data volumes that don't represent real usage patterns.
- If the test environment differs significantly from production, document
  the differences and how they affect the results.
