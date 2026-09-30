# Reusable prompt: concurrency & race condition debugging

Copy-paste the block below into any AI coding agent to hunt down race
conditions, deadlocks, and async bugs methodically instead of sprinkling
sleep calls and hoping.

Keywords: concurrency, race condition, deadlock, thread safety, locks, async bugs

---

Debug this concurrency problem (race condition, deadlock, flaky parallel
test, or async ordering bug). Concurrency bugs are proven, not guessed: you
must be able to explain the exact interleaving that causes the failure.

## Steps

1. **Reproduce reliably** - Find or build a reproduction that fails more
   often than not: stress loops, reduced delays, forced scheduling, raised
   thread/task counts. A repro you cannot trigger on demand cannot confirm a
   fix.
2. **Map shared state** - Identify exactly which data is shared across
   threads/tasks/processes, which accesses are reads vs writes, and what
   synchronization (locks, atomics, channels, transactions) currently guards
   them. Write the map down before theorizing.
3. **Explain the interleaving** - State the precise sequence of events that
   produces the bug: who writes what, who reads stale state, who observes a
   half-done update. If you cannot narrate the interleaving, keep digging.
4. **Pick the minimal fix** - Prefer the smallest correct mechanism: shrink
   critical sections, use the language's appropriate primitive (atomic,
   mutex, message passing, idempotent retry), or restructure to remove shared
   mutable state entirely. Never add a second lock where one lock held
   correctly suffices, and never "fix" with sleeps or timeouts.
5. **Prove it** - Run the stress repro many times pre-fix (show failures) and
   post-fix (show clean runs). Enable detectors if available (ThreadSanitizer,
   `-race`, deterministic-scheduling test tools). Run the full suite.
6. **Check neighbors** - Look for the same pattern elsewhere in the codebase
   and report locations; don't fix them silently.

## Rules

- Never claim fixed without demonstrating the interleaving is impossible or
  handled, backed by repeated clean runs.
- Sleep-based "fixes" are not fixes - reject them explicitly.
- Note deadlock potential of any new locking (lock ordering, reentrancy).
