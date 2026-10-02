# Reusable prompt: responsive design

Copy-paste the block below into any AI coding agent to audit and implement
responsive layouts - mobile-first, fluid, and tested at every breakpoint, not
"looks fine on my screen."

Keywords: responsive, breakpoints, mobile first, media queries, grid, layout

---

Audit and implement responsive design for `[page / component / layout]` in this
repository. The goal: a UI that works well at every screen size, built
mobile-first with fluid techniques, not breakpoint hacks.

## Steps

1. **Audit the current state** - Find fixed widths, hardcoded pixels, missing
   viewport meta tags, images without responsive handling, overflow at narrow
   widths, and cramped touch targets. Check the repo's existing breakpoint
   values and responsive utilities, then fix what you found.
2. **Define the breakpoint strategy** - Reuse the repo's breakpoints if it has
   them. Otherwise establish a mobile-first set: sm 640px, md 768px, lg 1024px,
   xl 1280px, and document it for the team.
3. **Implement mobile-first** - Start at the smallest screen and add complexity
   as width grows. Prefer relative units (rem, em, %, vw), flexbox/grid for
   layout, clamp() for fluid typography, aspect-ratio for media.
4. **Test at every breakpoint** - Check each breakpoint and the widths between
   them, in DevTools responsive mode or by hand: layout integrity,
   readability, touch targets (min 44x44px), nothing hidden or overlapping.
5. **Handle media and interaction** - Responsive images via srcset or picture,
   no hover-only functionality on touch, and mobile-appropriate input types
   (tel, email, number).

## Verification

- [ ] The repo's existing breakpoints were reused rather than a second scale
      invented.
- [ ] Layouts were built mobile-first, and no `!important` was used to override
      the cascade.
- [ ] No horizontal overflow at the narrowest supported width, and no truncated
      labels.
- [ ] Every breakpoint was actually tested, with the viewport widths recorded.
- [ ] Content hidden at a breakpoint has a stated UX reason; nothing was hidden
      to dodge a layout problem.
- [ ] Images use `srcset` and `sizes`, and no functionality depends on hover
      alone.

## Rules

- Never use `!important` to override responsive styles - fix the cascade
  instead.
- Never hide content at certain breakpoints unless there's a clear UX reason
  - content disappearing is a bug, not a feature.
- Never rely solely on hover states for important functionality - it doesn't
  exist on touch devices.
- If the repo uses a CSS framework (Tailwind, Bootstrap), use its built-in
  responsive utilities rather than custom media queries.
