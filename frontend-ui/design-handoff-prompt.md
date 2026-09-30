# Reusable prompt: design handoff to code

Copy-paste the block below into any AI coding agent to turn a visual design
(mockup image, Figma screenshot, or reference HTML) into code that matches
it closely and behaves responsively, using a comparison loop that finds the
gaps.

Keywords: design handoff, figma, mockup, design to code, design specs, assets

---

Implement `[the page or component]` to match the provided design
`[reference: link, file, or screenshot path]` in this repository. The goal
is visual parity at the target breakpoints - close enough that a side-by-side
comparison shows only intentional differences.

## Steps

1. **Extract the design tokens first** - Read the design and list its
   spacing, type scale, colors, radii, and shadows as named values. If the
   project has a design token file, map to it; if not, propose values that
   mirror the design exactly rather than approximating them inline.
2. **Note the unsupplied specifications** - Track every measurement the
   reference does not show (exact spacing, hover states, breakpoint
   behavior). List these as assumptions to confirm, and pick defaults
   consistent with the design system.
3. **Build with the existing components** - Use the repo's components and
   styles. Only write new CSS or new components when the design genuinely
   has no existing equivalent.
4. **Match layout at the target breakpoints** - Verify the composition holds
   at the breakpoints the design implies (mobile, tablet, desktop). A design
   drawn desktop-only still needs a defined, intentional mobile state.
5. **Compare, find gaps, fix** - Take a screenshot of the implementation at
   the same size as the reference and diff them side by side. List every
   visible difference (spacing, size, color, alignment), fix the real ones,
   and record which differences remain and why.
6. **Verify behavior and quality** - Confirm keyboard navigation, focus, and
   responsive behavior on the implemented element. Run the repo's tests and
   linters.

## Verification

- [ ] Every spacing, type, and color value in the output is traceable to the
      design or listed as an assumption.
- [ ] A side-by-side comparison was done and the remaining differences are
      named and justified.
- [ ] The component holds at the agreed breakpoints with no overflow or
      collapsed layout.
- [ ] Accessibility basics (keyboard, focus, contrast) pass on the new code.
- [ ] The repo's test suite and linters pass.

## Rules

- Never present invented measurements as coming from the design; tag them as
  assumptions.
- Never rebuild existing components; reuse them.
- Never call it done before the side-by-side comparison step.
- If the reference is ambiguous, list the ambiguity and your default rather
  than silently choosing.
