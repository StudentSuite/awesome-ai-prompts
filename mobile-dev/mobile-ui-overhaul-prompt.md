# Reusable prompt: mobile UI overhaul [spec]

Copy-paste the block below into any AI coding agent to overhaul a mobile UI
end-to-end: define a target design, reimplement the screens against the
project's conventions, and prove the result on every declared platform with
before/after evidence. An overhaul that only restyles one screen in a
hot-reload session is not an overhaul.

Keywords: mobile ui redesign, overhaul, navigation, platform native, refresh, restyle

---

Overhaul the UI of `[feature / the whole app]` for this mobile project. Define
what the target UI must be, reimplement the screens, and prove the result on
every declared platform with before/after evidence - preserving the app's
behavior, state, and data flows.

## Define the scope first

1. **Scope** - Which screens and flows are overhauled, and what stays
   untouched.
2. **Design direction** - The target look: tokens, layout, typography, motion
   to adopt. State it explicitly so the work can be checked against it; if the
   project has a design system, it is the baseline.
3. **Platforms and devices** - The platforms, OS version floor, and devices
   used to verify.
4. **Behavior constraints** - What must not change: state, data, navigation
   paths, offline and permission behavior. An overhaul is visual, not
   functional, unless the change is declared up front.
5. **Out of scope** - Store submission, content copy, and feature work.

## What to produce

1. **Target design spec** - The decisions written down: tokens, spacing scale,
   type scale, component patterns, motion, theming. Short enough to hold in
   mind, exact enough to check a screen against.
2. **Token layer** - The tokens and components introduced or changed first, so
   screens compose from them rather than diverge.
3. **Reimplemented screens** - Every in-scope screen rebuilt on the new layer,
   with file:line for each change.
4. **Preserved behavior** - A statement of which behaviors, states, and flows
   were confirmed unchanged, and how.
5. **Platform verification matrix** - A table of every in-scope screen per
   platform, device, OS, and theme, each row with a before and after capture
   and a pass/fail against the target spec.

## Method

1. **Baseline first** - Capture the current state of every in-scope screen on
   each declared platform before touching code. This is the "before" half.
2. **Read the current design architecture** - Tokens, shared components, and
   conventions. The overhaul is built on the project's own system.
3. **Build the token layer before screens** - Establish tokens and components
   first, then compose screens from them. Never hand-style a screen while the
   shared layer is missing.
4. **Rebuild screens, then verify behavior** - Reimplement the screens, then
   run the app and re-check the preserved behaviors and states, not just the
   new look.
5. **Verify on each platform** - Run every declared platform in each theme and
   at the large font scale at minimum, and capture the "after" shots. An
   overhaul is done only when its spec is demonstrated on the device.

## Verification

- [ ] Before and after captures exist for every in-scope screen on every
      declared platform, taken the same way.
- [ ] The target design spec is stated before implementation, and each screen
      is checked against it.
- [ ] All preserved behaviors (state, navigation, offline, permissions) are
      confirmed unchanged, with how they were confirmed.
- [ ] The app runs on every declared platform in each theme and at the
      declared accessibility scale.
- [ ] Tests pass and cover the flows the overhaul touched.
- [ ] No screen was hand-styled around a missing token or component; the
      shared layer is in place first.

## Rules

- Never change a behavior you cannot show still works. Verified expectations,
  not vibes.
- Never hand-style a screen around missing tokens; build the shared layer
  first.
- Never call it an overhaul when only one screen renders in a hot-reload
  session.
- Never claim a win without before and after evidence generated the same way.
- If a screen already meets the target spec, say so with evidence rather than
  changing it for change's sake.
