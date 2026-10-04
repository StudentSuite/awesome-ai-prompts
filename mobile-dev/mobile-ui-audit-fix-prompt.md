# Reusable prompt: mobile UI audit remediation [spec]

Copy-paste the block below into any AI coding agent to remediate every finding
from `mobile-ui-audit-prompt.md`. These two prompts are co-dependent: the audit
produces the findings; this prompt consumes them and fixes them with proof.

Keywords: mobile ui, audit remediation, tap targets, safe area, accessibility, platform conventions, verification

---

You are fixing the UI issues discovered by a mobile UI audit. Your job is to
address **every finding** from the audit report, in priority order, with
evidence-backed fixes. Do not refactor unrelated code. Do not invent new
issues.

## Prerequisites

1. **Audit report exists** - You must have the output from
   `mobile-ui-audit-prompt.md`. By default, read `AUDIT.md` at the repository
   root. If it is in a different path, use that path.
2. **Evidence available** - The audit report must include findings with
   `file:line`, current value, correct value, exact change needed, and
   screenshots/evidence where visual. If any finding is missing required
   fields, list them and stop.
3. **Scope is known** - The audit's stated platforms, devices, OS floor, screens,
   themes, and conventions are binding. Do not expand scope unless you state why
   and get confirmation.

Do not begin until all prerequisites are satisfied.

## What to produce

1. **Remediation plan** - Extract all findings from the audit report, group by
   the audit dimensions (platform conventions, touch targets/hit areas, safe
   areas/cutouts, layout across sizes/density/orientation, keyboard/input,
   states/feedback, accessibility, theming), and reorder by user impact:
   broken layouts → unreadable text → unreachable controls → safe areas/keyboard
   → states/feedback → accessibility nits → spacing/typography nits. Show a
   checklist of every finding (by ID/title + file:line).
2. **Fixes applied** - For each finding, apply the exact change specified. If
   the audit named a token/component to use, use it. If the audit said "use
   existing token X" and X does not exist, report that as a blocker with
   evidence, do not create a new token unless the audit explicitly allowed it.
3. **Fix report (AUDIT_FIXES.md)** - Write/update `AUDIT_FIXES.md` mapping each
   finding to a status: `fixed`, `waived` (with reason), or `blocked` (with
   blocker). For each `fixed` finding include: file:line changed, before→after
   diff summary, commit/patch reference, and "after" evidence (screenshots).
   For each `waived` finding, state why it matches an intentional, documented
   design choice and cite that document.
4. **Verification matrix** - A table of every in-scope screen per platform,
   device, OS, theme, and orientation, showing before→after captures taken the
   same way as the audit, plus pass/fail against each finding that affects that
   screen.
5. **Behavior guard** - Confirm preserved behaviors (state, navigation,
   permissions, offline, deep links, lifecycle) were not changed. List how you
   verified (tests run, manual checks on device/simulator).
6. **Build and test proof** - Show the app builds cleanly on every platform in
   scope, type checks/lint pass, and any tests covering touched flows still
   pass. Include command outputs or CI references.

## Method

1. **Parse the audit** - Read the full audit report (AUDIT.md by default).
   Extract: scope, platforms/devices, conventions, and the complete findings
   list with file:line, current, correct, exact change, evidence paths. Treat
   the audit as authoritative.
2. **Plan before coding** - Present the remediation plan checklist and confirm
   priority. Do not start edits until confirmed.
3. **Fix in priority order** - Work top-to-bottom by impact. For each finding,
   make the minimal change to satisfy "correct value". Prefer using existing
   tokens/components/shared styles. Do not bundle unrelated cleanups.
4. **Verify as you go** - After fixing a finding that affects layout/touch
   targets/safe areas/keyboard/accessibility, verify on the relevant platform(s)
   at the declared device(s). Re-check large font scale and affected themes.
5. **Prove with evidence** - Capture "after" screenshots from the same views
   used in the audit (same device, orientation, theme, scale). Update
   AUDIT_FIXES.md immediately with evidence and status.
6. **Final verification** - Re-run the verification checks from the audit where
   applicable (touch targets, safe areas, large font scale, keyboard, themes,
   accessibility). Confirm every finding is either `fixed` with evidence, or
   `waived` with documented justification.
7. **Build/test** - Build and run checks for all platforms in scope. Run tests
   for touched flows. Report pass/fail.

## Verification

- [ ] Every finding from the audit appears in AUDIT_FIXES.md with a status.
- [ ] All `fixed` findings cite specific file:line changes and include
      before→after evidence (screenshots) from device/simulator, not just code
      diff.
- [ ] Touch targets, safe areas, keyboard handling, large font scale,
      accessibility, and themes were re-checked on declared devices/platforms.
- [ ] Before→after captures exist for every screen affected by fixes, taken the
      same way as the audit.
- [ ] App builds cleanly on every platform in scope; lint/type checks and
      relevant tests pass.
- [ ] No behavior changes (state, navigation, permissions, offline, deep links,
      lifecycle) introduced. Documented confirmation exists.
- [ ] No finding was "fixed" by refactoring unrelated code. Changes are minimal
      and match the audit's exact change.
- [ ] Intentional design choices are only waived with citation to documented
      conventions.
- [ ] No new tokens/components were invented unless the audit explicitly
      allowed it.

## Rules

- Consume the audit report. Do not re-audit. Fix what the audit found.
- Fix all findings. If you cannot fix a finding without changing behavior or
  expanding scope, mark it `blocked` with a concrete blocker and do not guess.
- Use the project's existing tokens, components, and conventions. If missing and
  not allowed, block.
- Prioritize by user impact. Do not polish nits before fixing broken layouts or
  unreachable controls.
- Evidence is required. No status change without before→after proof on device
  or simulator for visual issues.
- These prompts are co-dependent. The audit defines the contract; this
  remediation must satisfy it completely.
