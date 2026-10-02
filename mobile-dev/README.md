# Mobile development

Prompts for iOS and Android: features, performance, UI audits, redesigns, and turning a website into an app.

Prompts carrying the light-blue badge are the heavyweight
[spec](../README.md#mobile-development) prompts: multi-section, with
hard constraints and required verification.

Back to the [main index](../README.md#mobile-development) or browse
[every prompt on one page](../ALL_PROMPTS.html).

## Prompts

- [mobile-app-develop-prompt.md](mobile-app-develop-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - build a mobile feature and prove it works on both platforms: offline, permissions, deep links, lifecycle, with a platform verification matrix.
- [mobile-performance-prompt.md](mobile-performance-prompt.md) - find and fix mobile performance from measurements: startup, frame rate, app size, memory, network.
- [mobile-ui-audit-prompt.md](mobile-ui-audit-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - audit a mobile UI against platform conventions: touch targets, safe areas, accessibility, states, theming, with file:line fixes.
- [mobile-ui-overhaul-prompt.md](mobile-ui-overhaul-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - overhaul a mobile UI end-to-end: target design spec, token layer, reimplemented screens, with before/after proof on every platform.
- [website-to-mobile-app-prompt.md](website-to-mobile-app-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - turn a website into a mobile app, choosing the adaptation strategy from the site's actual architecture: wrapper vs shared-logic vs native.

- [mobile-app-project-setup-prompt.md](mobile-app-project-setup-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - bootstrap a new mobile app: argued stack choice, feature-based structure, navigation skeleton, both platforms building from a clean clone on CI.

- [push-notifications-deep-links-prompt.md](push-notifications-deep-links-prompt.md) - implement notifications and deep links with permission and routing verification.$

## Adding a prompt here

Read [CONTRIBUTING.md](../CONTRIBUTING.md) for the file format and the gates,
model the new file on a neighbor in this folder, and add a one-line entry
above plus a [CHANGELOG.md](../CHANGELOG.md) entry under `[Unreleased]`.
