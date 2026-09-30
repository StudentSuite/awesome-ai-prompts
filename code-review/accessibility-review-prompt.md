# Reusable prompt: accessibility review

Copy-paste the block below into any AI coding agent to audit UI code for
accessibility compliance - WCAG-concrete findings with fixes, not a generic
"use alt text" checklist.

Keywords: accessibility, a11y, wcag, screen reader, keyboard navigation, aria

---

Review the accessibility of `[component / page / feature]` in this repository.
The goal: ensure the UI is usable by people relying on keyboards, screen
readers, and assistive technologies, meeting WCAG 2.1 AA at minimum.

## Scope to cover

1. **Semantic HTML** - Check that elements use appropriate tags (button vs div,
   nav, main, heading hierarchy, lists). Flag div/span soup that should be
   semantic elements.
2. **Keyboard navigation** - Verify all interactive elements are focusable,
   focus order is logical, focus is visible, and no keyboard traps exist.
   Check for Escape to close modals, Tab/Shift+Tab navigation, Enter/Space
   activation.
3. **Screen reader support** - Check for meaningful alt text on images,
   aria-labels on icon-only buttons, aria-live regions for dynamic content,
   proper form labels, and that dynamic content announcements work.
4. **Color and contrast** - Verify text meets WCAG contrast ratios (4.5:1 for
   normal text, 3:1 for large text). Check that color is not the only way to
   convey information (error states, status indicators).
5. **Forms and inputs** - Verify every input has an associated label, error
   messages are programmatically associated with their fields, required fields
   are indicated, and fieldsets/groupings are used where appropriate.
6. **Motion and timing** - Check for respects-preference-of-reduced-motion,
   auto-playing animations with no pause control, and time limits without
   extensions.

## Method

1. **Read the actual markup** - Examine the HTML/JSX/template for each
   component. Do not guess from the visual output - read the DOM structure.
2. **Trace the keyboard path** - Walk through every interactive element in tab
   order. Verify each can be reached, activated, and escaped with keyboard
   alone.
3. **Cite specific instances** - For each finding, reference the exact file:line
   and the specific WCAG success criterion violated (e.g. 1.1.1, 2.1.1,
   4.1.2).
4. **Propose concrete fixes** - Show the code change needed, not just "add
   aria-label". Include the specific attribute or element swap.

## Rules

- Never report "could be more accessible" without specifying what fails and
  which WCAG criterion it violates.
- Never recommend aria attributes as a first resort when a semantic HTML
  element would be simpler and more robust.
- If the UI is already accessible, say so and list what was verified rather
  than inventing issues.
- Do not flag visual-only decorative elements (purely decorative images,
  ornamental dividers) as missing alt text.
