# Reusable prompt: memory leak hunting

Copy-paste the block below into any AI coding agent to hunt down a memory leak
in a running service: measure the growth, isolate what retains memory, apply a
minimal fix, and verify the allocation curve goes flat under the same load.

Keywords: memory leak, heap, leak detection, retained objects, profiling, valgrind

---

Find and fix the memory leak in `[service or component]`. Work from
measurements, never from suspicion: a process that "seems to grow" is not
evidence. Establish the baseline curve, reproduce steady growth, isolate the
retainer, fix it minimally, and prove the curve flattens.

## Steps

1. **Baseline, then reproduce** - Find the repo's own memory tooling and how
   the service runs, and record RSS plus heap across a fixed window of normal
   work. Then drive one repeatable scenario (same request, looped) and show the
   allocation curve rising with loop count.
2. **Find the retainer** - Diff two heap snapshots, or sampling profiles, taken
   one interval apart to see which objects and which root hold them. Check the
   usual suspects with evidence: an unbounded cache or public static
   collection, listeners never removed, uncleared timers, closures holding
   large objects, pooled objects accumulating fields, unclosed streams or
   connections.
3. **Fix the smallest thing** - Change the retainer, not the surroundings:
   bound or evict the cache, remove the listener on unmount, clear the
   interval, close the stream. Prefer the boring fix that drops the reference
   over a clever rewrite.
4. **Re-run the same loop** - Run step 1's exact scenario at least as long as
   before and show the curve flat or bounded where it used to climb. Report the
   before and after numbers.

## Verification

- [ ] The baseline was taken with the repo's own memory tooling, with the
      method stated.
- [ ] The growth was reproduced by a repeatable scenario, and the same scenario
      was reused to verify the fix.
- [ ] An allocation snapshot names a specific retainer, not a suspicion.
- [ ] The fix changes the retainer rather than its surroundings, and one change
      was made at a time.
- [ ] The exact loop was re-run post-fix and the curve is flat.
- [ ] No feature was disabled and no periodic GC or pool added to mask the
      symptom.
- [ ] The diff touches only the leak path and its test.

## Rules

- Never patch based on an anecdote. Every change must be tied to a measured
  retainer from a snapshot, not a guess.
- One fix per investigation until the curve is flat; do not stack unrelated
  memory changes in the same change.
- Never disable a feature to hide the leak, and never add a periodic GC or pool
  flush as the "fix" without proving the root cause.
- No unrelated edits: this change only touches the leak path and its test.
