# Reusable prompt: design tokens that survive dark mode and a rebrand

Copy-paste the block below into any AI coding agent to replace hardcoded values
with a three-layer token system, verify contrast per pair instead of assuming
dark mode works, and produce a migration that lands in slices.

Keywords: design tokens, theming, dark mode, semantic tokens, contrast

---

Convert `[component library or app]` to a token system in `[stack]`. A token is
worth having only if a component can reference it without knowing what color it
is, so the work is naming and layering as much as values. Deliver the token
files, the contrast table, the pipeline decision with its tradeoff, and the
migration order.

## Steps

1. **Inventory the hardcoded values** - Search the repo for hex colors, pixel
   radii, shadow strings, and raw font sizes, including inline styles, styled
   component objects, and SVG fills. Produce a count per file so the migration
   has a denominator and the finished state can be proven rather than asserted.
2. **Define the three layers** - Primitives are raw values with no meaning,
   such as a blue at a given step. Semantic tokens state a role: surface,
   text-muted, border-subtle, danger, focus ring. Component tokens exist only
   when a component genuinely needs its own knob. Components reference semantic
   tokens only; a primitive used directly in a component is a defect.
3. **Name by role, never by value** - A token named after its hex step cannot
   answer "what is this in dark mode", so it forces a parallel set. Names should
   encode intent, which makes a palette change or a second brand a value swap in
   the primitive layer and nowhere else.
4. **Re-map for dark mode, do not invert** - Write an explicit table mapping
   every semantic token to its dark value, then measure contrast for each
   text-on-surface and border-on-surface pair in both themes and paste the
   ratios. Elevation shadows usually need stronger contrast in dark mode, which
   a mechanical inversion gets wrong. Note every pair that fails and fix it.
5. **Choose the pipeline and say why** - CSS custom properties: no build step,
   runtime theming, values visible in devtools; the cost is no compile-time
   type checking and one root attribute flip. A build-time pipeline that emits
   tokens to CSS or to typed constants: enforced single source and no runtime
   lookup; the cost is a build step and generated files to keep in sync. Pick
   one, state the tradeoff in a sentence, and show the losing option's shape.
6. **Encode the theme switch** - One attribute or class on the root, applied
   before first paint so there is no flash of the wrong theme, with a stored
   user preference taking priority over the system default. Add more than light
   and dark only if the semantic layer genuinely holds up.
7. **Land it in slices** - Order the work shared primitives first, then tokens,
   then components in dependency order, each slice visually unchanged and
   independently revertible. Add a check that fails on new hardcoded values, and
   delete the old values rather than leaving two sources of truth.

## Rules

- Components reference semantic tokens only; primitives are reached only through
  a semantic mapping.
- No hex value, pixel radius, or shadow string survives outside the primitive
  layer.
- Contrast is measured per pair per theme and pasted, never inferred from a
  palette looking dark.
- Dark mode is an explicit mapping table, not an automated inversion.
- One root theme attribute, set before first paint, with the stored preference
  beating the system default.

## Verification

Paste the inventory counts before the change, the contrast table with measured
ratios for both themes, the chosen pipeline and its tradeoff, a before and after
screenshot of the same route in both themes, and the search that proves no
hardcoded value remains outside the primitive layer.
