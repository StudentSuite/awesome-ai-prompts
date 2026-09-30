# Reusable prompt: mobile UI audit [spec]

Copy-paste the block below into any AI coding agent to audit a mobile UI at
spec level: platform conventions, touch targets, safe areas, accessibility,
states, and theming - with evidence-backed findings that cite exact file:line
and a verifiable fix for each one. Mobile UI lives on the device, so the audit
runs on a real screen, not a web-inspector view of a portrait render.

Keywords: mobile ui, tap targets, safe area, platform guidelines, polish, small screens

---

Audit the UI of `[screen / flow / feature]` in this mobile project against the
platform conventions it must run on (iOS and/or Android) and the project's own
design conventions. Produce a prioritized list of findings, each with a
concrete fix that can be checked against the codebase - not a style wishlist.

## Define the scope first

1. **Platforms and devices** - Which platforms are in scope, the OS version
   floor, and the concrete devices and screen sizes to audit (small phone,
   large phone, tablet if in scope).
2. **Screens and flows** - The specific screens, routes, and flows to cover.
3. **Design conventions in use** - The tokens, theme, and component
   conventions the project follows. If none exist, say so and recommend one; do
   not invent one.
4. **Out of scope** - Anything explicitly excluded.

Do not begin until the scope and conventions are defined and confirmed.

## Audit dimensions

For every in-scope screen, check these dimensions in order. Stop on a broken
layout before moving to spacing nuance.

1. **Platform conventions** - Layout, controls, and navigation follow the
   platform idiom (iOS or Android): tab bar vs bottom nav, back affordance,
   swipe-back, pickers and dialogs, feedback patterns. Flag inverted or mixed
   conventions.
2. **Touch targets and hit areas** - Every interactive element is at least
   44x44 pt (iOS) / 48 dp (Android), with the real tappable bounds equal to or
   larger than the visual bounds, never smaller. Flag undersized targets and
   overlapping hit areas.
3. **Safe areas and cutouts** - Content clears the notch, camera cutout,
   status bar, home indicator, and rounded corners on the declared devices.
   Flag layouts that assume a full rectangle.
4. **Layout across sizes, density, and orientation** - Check on the declared
   devices at the densities they actually render (@1x/@2x/@3x), portrait and
   landscape. Flag clipped text, off-screen content, and fixed-pixel layouts
   that break on a smaller device.
5. **Keyboard and input** - Focused fields are never obscured by the keyboard,
   the layout responds when the keyboard opens, and fields use the right input
   type (email, number, phone) so the correct keyboard appears.
6. **States and feedback** - Loading, empty, error, success, offline, and
   retry states exist and are consistent. Interactive elements give visible
   feedback on tap; silent failures are flagged.
7. **Accessibility** - The UI holds at larger font and dynamic-type scales
   without clipped text, contrast meets the platform minimum, and every element
   is reachable by screen reader and keyboard. Flag touch-only dependencies.
8. **Theming** - If the project supports light/dark (or more) themes, each
   screen is checked in every supported theme. Hardcoded colors that break a
   theme are flagged.

## Method

1. **Read the design architecture first** - Find the token definitions, theme,
   and shared components before auditing. You audit against the project's own
   system, not an invented one.
2. **Read each screen's layout and style code** - Note dimensions, colors, and
   constraints with the specific file:line and value for every deviation.
3. **Run it, do not just read it** - On each declared platform, run the app on
   a device or simulator at the declared OS, in portrait and landscape, at the
   large font scale and in each theme. Capture screenshots as evidence.
4. **Group findings by dimension** - Organize everything under its audit
   dimension, not as a flat list.
5. **Show the fix, not just the problem** - For each finding: file:line, the
   current value, the correct value, and the exact change. If a token or shared
   component should be used, name it.

## Verification

- [ ] Every finding cites a specific file:line, not a vague location.
- [ ] No finding invents a platform or design convention the project does not
      have; missing conventions are reported, not assumed.
- [ ] Findings are prioritized: broken layouts, unreadable text, and
      unreachable controls first, minor spacing and typography nits last.
- [ ] Each platform in scope was run (device or simulator), not only read in
      code.
- [ ] Touch targets, safe areas, and large font scale were checked on every
      in-scope screen.
- [ ] Intentional, documented design choices are not flagged unless they
      conflict with a platform requirement.
- [ ] If the UI already meets the conventions within scope, that is stated
      explicitly with what was verified, not padded with invented issues.

## Rules

- State the scope, platforms, devices, and conventions before auditing. Do not
  audit a moving target.
- Never report "could be more consistent" without specifying what is
  inconsistent, where it is, and what the correct value should be.
- Never invent tokens, components, or platform guidelines the project does not
  have.
- Do not flag intentional, documented design choices as errors.
- Prioritize by user impact: a clipped screen at large font scale outranks a
  2pt spacing nit.
- If the UI is already consistent within scope, say so and list what was
  verified - do not invent issues to fill the report.
