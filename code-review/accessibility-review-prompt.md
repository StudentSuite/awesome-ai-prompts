# Reusable prompt: accessibility review

Copy-paste the block below into any AI coding agent to audit UI code for
accessibility compliance - WCAG-concrete findings with fixes, not a generic
"use alt text" checklist.

Keywords: accessibility, a11y, wcag, screen reader, keyboard navigation, aria

---

Review the accessibility of `[component / page / feature]` in this repository.
The goal: ensure the UI is usable by people relying on keyboards, screen
readers, and assistive technologies, meeting WCAG 2.1 AA at minimum.

## Steps

1. **Read the actual markup** - Examine the HTML/JSX/template for each
   component. Do not guess from the visual output - read the DOM.
2. **Check semantics** - Appropriate tags (button vs div, nav, main, heading
   hierarchy, lists). Flag div/span soup that should be semantic elements.
3. **Trace the keyboard path** - Walk every interactive element in tab order:
   each must be focusable, reachable, activatable with Enter/Space, escapable
   (Escape closes modals), with logical order, visible focus, and no keyboard
   traps.
4. **Check screen reader support** - Meaningful alt text on meaningful images,
   aria-labels on icon-only buttons, aria-live regions for dynamic content,
   and labels programmatically associated with form inputs.
5. **Check color and contrast** - WCAG ratios: 4.5:1 normal text, 3:1 large
   text. Color must not be the only way to convey error states or status.
6. **Check forms and motion** - Every input labeled, errors associated with
   their field, required fields indicated, fieldsets where appropriate; and
   prefers-reduced-motion honored, no unstoppable autoplay, no bare time
   limits.
7. **Cite and fix** - For each finding, name the file:line and the WCAG
   success criterion violated (1.1.1, 2.1.1, 4.1.2), then show the concrete
   element or attribute swap, not just "add aria-label".

## Verification

- [ ] Every finding names a file:line and the specific WCAG success criterion it violates.
- [ ] Every interactive element was traced in tab order and can be reached, activated, and escaped.
- [ ] Contrast ratios were measured against the WCAG minimums, not estimated by eye.
- [ ] Each proposed fix shows the concrete element or attribute change.
- [ ] Decorative elements were excluded from alt-text findings.

## Rules

- Never report "could be more accessible" without specifying what fails and
  which WCAG criterion it violates.
- Never recommend aria attributes as a first resort when a semantic HTML
  element would be simpler and more robust.
- If the UI is already accessible, say so and list what was verified rather
  than inventing issues.
- Do not flag visual-only decorative elements (purely decorative images,
  ornamental dividers) as missing alt text.
