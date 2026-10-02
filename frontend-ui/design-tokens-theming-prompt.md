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

1. **Inventory the hardcoded values** - Search components, styles, and inline
   styles for hex colors, pixel spacing, radii, shadows, font sizes, and
   z-index. That list is the migration's work queue.
2. **Define three layers, named by role** - Primitives are raw values with no
   meaning (`blue-600`, `space-4`); semantic tokens name a role
   (`text-primary`, `surface-raised`); component tokens cover the cases where
   one component needs its own knob. A token named after its hex step asserts
   the value, so it cannot survive a theme change.
3. **Re-map for dark mode, do not invert** - An explicit token-to-dark-theme
   table; automated inversion shifts hue badly and gives unreadable contrast.
4. **Choose the pipeline and say why** - Custom properties need no build step;
   one pays off only for multi-brand output, aliasing, or a runtime theme API.
5. **Encode the switch, land in slices** - One root attribute or class applied
   before first paint, honoring the stored preference over the system default.
   Ship shared primitives, then tokens, then components, each slice leaving
   the app working and visibly unchanged.

## Verification

- [ ] Components reference semantic tokens only; primitives are reached only
      through a semantic layer.
- [ ] No hex value, pixel radius, or shadow string survives outside the
      primitive definitions.
- [ ] Contrast is measured per token pair per theme and the numbers are pasted,
      not inferred.
- [ ] Dark mode is an explicit mapping table, not an automated inversion.
- [ ] The theme attribute is set before first paint, and the stored preference
      is restored on load.
- [ ] Every slice left the app rendering correctly and identically to before.

## Rules

- Components reference semantic tokens only; primitives are reached only
  through a semantic mapping.
- No hex value, pixel radius, or shadow string survives outside the primitive
  layer.
- Contrast is measured per pair per theme and pasted, never inferred from a
  palette looking dark.
- Dark mode is an explicit mapping table, not an automated inversion.
- One root theme attribute, set before first paint, with the stored preference
  beating the system default.
