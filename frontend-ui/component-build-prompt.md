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

1. **Understand the design system** - Read the existing components, design
   tokens (colors, spacing, typography), and UI patterns in the codebase.
   Understand the conventions: how components are structured, how props are
   typed, how styling is applied (CSS modules, Tailwind, styled-components,
   CSS-in-JS). Follow these exactly.
2. **Define the API** - Design the component's props: what it accepts, what's
   required vs optional, sensible defaults. Keep the API minimal - props
   should be intuitive and not require reading docs to use. Use TypeScript
   types or equivalent for prop validation.
3. **Handle variants and states** - Support the common variants (size, color,
   style) and states (disabled, loading, error, empty). Use composition
   patterns (children, render props, compound components) over boolean prop
   proliferation.
4. **Build it accessible** - Ensure keyboard navigation works, focus is
   visible, ARIA attributes are correct, color meets contrast requirements,
   and screen readers announce state changes. Reference the accessibility
   review checklist in this repo.
5. **Add stories or examples** - Create Storybook stories (or equivalent
   documentation) showing: each variant, each state, edge cases (long text,
   no data, error state), and composition with other components.
6. **Verify** - Test the component manually: keyboard-only navigation,
   screen reader output, responsive behavior. Run the test suite. Check that
   the component renders correctly across the supported browsers.

## Rules

- Never build a component that only works in one specific context - it must
  be reusable.
- Never hardcode values that should come from design tokens (colors, spacing,
  fonts).
- Never skip accessibility - a component that isn't accessible is not done.
- If the codebase already has a similar component, extend it rather than
  building from scratch.
