# Reusable prompt: mobile app development [spec]

Copy-paste the block below into any AI coding agent to build a mobile app
feature and verify it on real platforms - not just a single simulator
screen. The agent must prove the feature survives no signal, revoked
permissions, backgrounding, and platform differences.

Keywords: mobile app, react native, flutter, expo, app development, store submission

---

Build `[the mobile feature]` for this project and prove it works on a real
device or emulator for each supported platform. The goal: a feature that
survives the conditions real apps face - offline, permission denied,
background and restore, and platform quirks - not one that only renders
in a hot-reload session.

## Define the scope first

1. **Platforms** - Which platforms are in scope (iOS, Android, both) and what
   OS version floor applies. State the devices and OS versions you will
   verify on.
2. **The feature's requirements** - The exact behavior, inputs, and outputs,
   plus the defined offline and error behavior when a required dependency is
   unavailable.
3. **What is out of scope** - Platform-specific workarounds for platforms out
   of scope, store submission metadata, and analytics.

## What to produce

1. **The implementation** - Screen and flow code, state, and data layer for
   the feature, following the project's existing navigation, state, and
   styling conventions. Cite the files you changed.
2. **Permission handling** - Every permission the feature needs, when it is
   requested, what the denied path does, and why each permission is
   necessary. No silent crash on denial.
3. **Connectivity behavior** - What happens on the happy path, offline, and
   when a request times out or returns an error. Retry or cached state must
   be explicit, never accidental.
4. **Deep links and lifecycle** - How the feature behaves when opened from a
   deep link, backgrounded, killed, and restored. Cold-start state must be
   defined.
5. **Platform verification matrix** - A table of what was tested on which
   platform, device, and OS: launch, happy path, permission denied, offline,
   background/resume, and any platform-specific quirks found.

## Method

1. **Read the mobile project's conventions** - Navigation, state management,
   styling, and existing platform-specific code. Follow them.
2. **Fake the dependencies first** - Wire the feature against explicit
   interfaces so connectivity, permissions, and deep links can be exercised
   deterministically in tests and on simulators.
3. **Build the happy path, then the failure paths** - Implement the flow,
   then make denied permissions, offline, and timeout each produce a
   defined state.
4. **Verify on each platform** - Run on every declared platform: a real
   device if possible, otherwise the platform emulator at a realistic OS
   version. Exercise airplane mode, permission revocation, background/kill,
   and deep link entry.

## Verification

- [ ] The feature runs on every declared platform, proven by a run log per
      platform with the OS and device named.
- [ ] Permission denied produces a handled state (message, fallback, retry),
      never a crash.
- [ ] Offline behavior is verified with airplane mode on, and the state
      restores correctly when connectivity returns.
- [ ] Deep link entry and background/resume are tested and behave per spec.
- [ ] The test suite passes and covers the failure paths, not just the happy
      path.

## Rules

- Never ship a platform you have not run and seen behave.
- Never request a permission you cannot justify in the verification matrix.
- Never let a network failure surface as an unhandled error screen.
- If behavior differs by platform, handle it explicitly and note it - do not
  paper over it.
