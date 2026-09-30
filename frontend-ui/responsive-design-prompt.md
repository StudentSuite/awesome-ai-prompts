# Reusable prompt: responsive design

Copy-paste the block below into any AI coding agent to audit and implement
responsive layouts - mobile-first, fluid, and tested at every breakpoint,
not "looks fine on my screen."

Keywords: responsive, breakpoints, mobile first, media queries, grid, layout

---

Audit and implement responsive design for `[page / component / layout]` in
this repository. The goal: a UI that works well at every screen size, built
mobile-first with fluid techniques, not breakpoint hacks.

## Steps

1. **Audit the current state** - Read the existing CSS/styling and identify:
   fixed widths, hardcoded pixel values, missing viewport meta tags, images
   without responsive handling, and layouts that break at narrow widths.
   Check the repo's existing breakpoint values and responsive utilities.
2. **Define the breakpoint strategy** - Use the repo's existing breakpoints
   if defined. If not, establish a standard mobile-first set: sm (640px),
   md (768px), lg (1024px), xl (1280px). Document the breakpoints for the
   team.
3. **Implement mobile-first** - Start with the smallest screen layout and
   add complexity as width increases. Use relative units (rem, em, %, vw)
   over fixed pixels. Apply fluid techniques: flexbox/grid for layout,
   clamp() for fluid typography, aspect-ratio for media.
4. **Fix layout issues** - Address: overflow at narrow widths, text that's
   too small to read, touch targets too close together, horizontal
   scrolling, images that stretch or crop poorly, and content that
   disappears at certain widths.
5. **Test at every breakpoint** - Manually verify (or use browser DevTools
   responsive mode) at each defined breakpoint and in between. Check:
   layout integrity, readability, touch target sizes (min 44x44px), and
   that no content is hidden or overlapping.
6. **Handle media and interaction** - Ensure responsive images with srcset
   or picture element, touch-friendly interactions (no hover-dependent
   functionality on touch), and appropriate input types on mobile (tel,
   email, number).

## Rules

- Never use `!important` to override responsive styles - fix the cascade
  instead.
- Never hide content at certain breakpoints unless there's a clear UX reason
  - content disappearing is a bug, not a feature.
- Never rely solely on hover states for important functionality - it doesn't
  exist on touch devices.
- If the repo uses a CSS framework (Tailwind, Bootstrap), use its built-in
  responsive utilities rather than custom media queries.
