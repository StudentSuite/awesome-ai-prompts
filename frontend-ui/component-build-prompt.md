# Reusable prompt: component build

Copy-paste the block below into any AI coding agent to build a reusable,
accessible UI component - with proper props, variants, and stories, not a
one-off hardcoded element.

Keywords: component, react component, ui component, props, composition, building ui

---

Build a reusable UI component for `[component name and purpose]` in this
repository. The goal: a component that works across multiple contexts, is
accessible, and follows the project's design system conventions.

## Steps

1. **Read the design system** - Existing components, design tokens, and UI
   patterns: how they are structured, typed, and styled (CSS modules,
   Tailwind, styled-components). Follow the existing conventions exactly.
2. **Define the API** - What it accepts, what is required vs optional, and
   sensible defaults. Keep props minimal and intuitive, and type them.
3. **Cover variants and states** - Sizes, colors, styles; disabled, loading,
   error, empty. Prefer composition (children, render props, compound
   components) over boolean prop piles.
4. **Build it accessible** - Keyboard navigation, visible focus, correct ARIA,
   contrast, and announced state changes. Use the accessibility review
   checklist in this repo.
5. **Add stories or examples** - Write Storybook stories (or equivalent) for
   every variant, every state, edge cases (long text, no data, error), and
   composition with other components.
6. **Verify by hand** - Keyboard-only navigation, screen reader output,
   responsive behavior. Run the test suite and the supported browsers.

## Verification

- [ ] The existing design system and components were read, and a similar
      component was extended rather than duplicated.
- [ ] Props cover the real API: variants, states, and composition, with
      sensible defaults.
- [ ] Every variant and state renders, including empty, loading, error, and
      disabled.
- [ ] Keyboard navigation, focus order, visible focus, and screen-reader
      labelling were exercised.
- [ ] No color, spacing, radius, or typography value is hardcoded; all come
      from tokens.
- [ ] Stories or examples exist, and the component was tested manually, not
      only through snapshots.

## Rules

- Never build a component that only works in one specific context - it must be
  reusable.
- Never hardcode values that should come from design tokens (colors, spacing,
  fonts).
- Never skip accessibility - a component that isn't accessible is not done.
- If the codebase already has a similar component, extend it rather than
  building from scratch.
