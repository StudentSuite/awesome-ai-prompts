# System design

Prompts for decisions above a single file: architecture, tradeoffs, and the concurrency or caching that follows from them.

Prompts carrying the light-blue badge are the heavyweight
[spec](../README.md#system-design) prompts: multi-section, with
hard constraints and required verification.

Back to the [main index](../README.md#system-design) or browse
[every prompt on one page](../ALL_PROMPTS.html).

## Prompts

- [system-design-prompt.md](system-design-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - design a scalable system end-to-end: requirements, components, tradeoffs, failure modes, phased build.
- [adr-writing-prompt.md](adr-writing-prompt.md) - record a technical decision as a two-minute ADR: context, options, consequences.
- [technical-debt-triage-prompt.md](technical-debt-triage-prompt.md) - inventory tech debt with evidence and get a prioritized paydown plan.
- [concurrency-debugging-prompt.md](concurrency-debugging-prompt.md) - hunt race conditions and deadlocks: prove the interleaving, minimal fix, stress-verified.
- [caching-strategy-prompt.md](caching-strategy-prompt.md) - add caching that pays for itself: measured wins, invalidation designed up front.

## Adding a prompt here

Read [CONTRIBUTING.md](../CONTRIBUTING.md) for the file format and the gates,
model the new file on a neighbor in this folder, and add a one-line entry
above plus a [CHANGELOG.md](../CHANGELOG.md) entry under `[Unreleased]`.
