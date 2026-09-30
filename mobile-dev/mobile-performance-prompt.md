# Reusable prompt: mobile performance

Copy-paste the block below into any AI coding agent to find and fix mobile
performance problems from measurements - startup, frame rate, app size,
memory, and network - with before/after proof for every change.

Keywords: mobile performance, startup time, battery, jank, scroll smoothness, profiling

---

Improve `[what is slow: startup, scrolling, bundle size, memory, or network]`
for this mobile project. Measure each problem on a real device or emulator
first, identify what actually costs you, fix the few things that matter, and
prove the result with the same measurement method before and after.

## Steps

1. **Establish the baseline** - Measure the current state on a device or
   emulator with developer options enabled: cold and warm startup, scroll
   frame rate, app size at build output, and, if requested, memory and
   network profile. Record the tool and setup used so results are
   reproducible.
2. **Profile, don't guess** - Use the platform profiler (Android Profiler,
   Instruments, React Native or Flutter DevTools, or the framework's own
   tools) to find what actually costs time or bytes. A claim without a
   profile data point is a guess.
3. **Fix the real costs** - Apply the smallest fix that targets a measured
   bottleneck: lazy loading, image and asset handling, list virtualization,
   expensive work off the main thread, or fewer and smaller requests. Prefer
   changes that move the measured number.
4. **Re-measure identically** - Repeat the same measurement with the same
   tool and setup. Report before and after numbers and the delta - and be
   honest if a change did not move the needle.
5. **Guard the win** - Add a regression guard where practical: a size check, a
   CI performance threshold, or a test that fails when the metric regresses.

## Verification

- [ ] A reproducible baseline exists before any change.
- [ ] Every fix is tied to a profile data point, not a suspicion.
- [ ] Before and after were measured with the same tool and setup, and the
      delta is reported.
- [ ] Targets are stated (for example "cold start under 2s on a mid-range
      device") and checked against the after measurement.
- [ ] A regression guard is in place, or a reason is given why one is not.

## Rules

- Never optimize a path you have not measured on the target platform type.
- Never claim a win without identical before/after measurement.
- Never ship a size or memory regression to fix a startup one without saying
  so.
- Prefer a few measured wins over many speculative micro-optimizations.
