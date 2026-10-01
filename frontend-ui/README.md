# Frontend & UI

Prompts for browser UI: components, layout, state, performance, accessibility, SEO, and localization.

Prompts carrying the light-blue badge are the heavyweight
[spec](../README.md#frontend--ui) prompts: multi-section, with
hard constraints and required verification.

Back to the [main index](../README.md#frontend--ui) or browse
[every prompt on one page](../ALL_PROMPTS.html).

## Prompts

- [component-build-prompt.md](component-build-prompt.md) - build a reusable, accessible UI component with props, variants, and stories.
- [responsive-design-prompt.md](responsive-design-prompt.md) - audit and implement responsive layouts: breakpoints, fluid grids, mobile-first.
- [state-management-prompt.md](state-management-prompt.md) - give every piece of client state one home; compute derived data, delete sync bugs.
- [web-performance-vitals-prompt.md](web-performance-vitals-prompt.md) - fix Core Web Vitals from measurements: LCP, INP, CLS with before/after proof.
- [i18n-localization-prompt.md](i18n-localization-prompt.md) - internationalize properly: extracted strings, ICU plurals, RTL, pseudo-locale testing.
- [website-seo-prompt.md](website-seo-prompt.md) - technical SEO audit: crawlability, canonicalization, metadata, structured data, redirects, and speed - with verification at every step.
- [instagram-carousel-prompt.md](instagram-carousel-prompt.md) - turn this repo into a branded, swipeable Instagram carousel delivered as self-contained 1080x1080 HTML slides, mirroring the repo's brand identity.
- [ui-audit-prompt.md](ui-audit-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - audit UI for visual consistency, design system adherence, spacing, typography, and responsive behavior with concrete fixes and file:line evidence.
- [design-handoff-prompt.md](design-handoff-prompt.md) - turn a mockup into token-aligned, responsive code with a screenshot comparison loop.

- [design-tokens-theming-prompt.md](design-tokens-theming-prompt.md) - theming that survives dark mode and a rebrand: token taxonomy, primitive to semantic to component layers, per-pair contrast, a migration off hardcoded values.

## Adding a prompt here

Read [CONTRIBUTING.md](../CONTRIBUTING.md) for the file format and the gates,
model the new file on a neighbor in this folder, and add a one-line entry
above plus a [CHANGELOG.md](../CHANGELOG.md) entry under `[Unreleased]`.
