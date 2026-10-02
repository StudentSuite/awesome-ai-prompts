# Reusable prompt: error handling strategy

Copy-paste the block below into any AI coding agent to design and apply one
coherent error handling strategy across a component or service: every failure
mode mapped to a typed error, a log line that can be searched, and a documented
policy for what is retried versus what reaches the user.

Keywords: error handling, exceptions, retries, failure modes, resilience, error boundaries

---

Design and apply a consistent error handling strategy for `[component or
service]` in this repository. The goal: no bare try/catch, no swallowed
errors, no unhandled crash on a path a user can hit. Inspection here means
reading code, not trusting it.

## Steps

1. **Read the existing conventions** - Find how this repo handles errors today: exception types, the logging library, API response envelopes, retry utilities, and where errors are caught. Mirror the existing style unless it is the problem. Note every catch that swallows the error or logs without context.
2. **Map the failure modes** - Enumerate every way this code can fail: transport and timeouts, persistence, validation and authorization, bad inputs, resource limits. For each, name where it surfaces and what happens to the caller today. Find the failure sites; do not guess them.
3. **Write one small policy** - Which failures are recoverable (retry with backoff behind an idempotency guard), which are fail-fast (crash loudly rather than silently drop), and which map to a user-visible message. Distinguish programming errors, which are bugs, from expected failures, which are control flow.
4. **Type the errors** - A small set of typed errors so callers branch on intent rather than message text, each carrying operation, resource, a retryable flag, and a stable code for logs and monitors.
5. **Implement the smallest change** - Route each catch through the policy. Retry only where the operation is idempotent and the failure transient. Never wrap a generic catch in silence: log the full context, then rethrow or map to a clean failure.
6. **Verify by injection** - Force each failure mode (point config at a dead endpoint, close a pool, pass bad data) and confirm the log line is debuggable, the retry backs off, and the user path returns the intended result. Show before and after.

## Verification

- [ ] Every catch that swallows an error or logs without context was found before the policy was written.
- [ ] Callers branch on typed errors or codes, not on message text.
- [ ] No user-facing message leaks SQL, stack traces, secrets, or internal type names.
- [ ] Each failure mode was actually injected, with the resulting log line, retry behavior, and user-visible result shown.
- [ ] The full suite passes, and no error path remains that catches and ignores.

## Rules

- Never add a catch block that swallows the error or logs without context.
- Never guess which failures can happen: find the failure sites in the code
  and list them before deciding the policy.
- Keep the policy close to the code it governs, not a page of theory elsewhere.
- No unrelated edits: this PR leaves the surrounding behavior unchanged unless
  a path was actually erroring silently.
