# Code review & quality

Prompts for reading someone else's code and reporting what is wrong, with evidence, a severity, and a fix.

Prompts carrying the light-blue badge are the heavyweight
[spec](../README.md#code-review--quality) prompts: multi-section, with
hard constraints and required verification.

Back to the [main index](../README.md#code-review--quality) or browse
[every prompt on one page](../ALL_PROMPTS.html).

## Prompts

- [secure-code-review-prompt.md](secure-code-review-prompt.md) - security-lens review: injection, authz, data exposure, with evidence.
- [performance-review-prompt.md](performance-review-prompt.md) - review code for performance anti-patterns with evidence and specific fixes.
- [accessibility-review-prompt.md](accessibility-review-prompt.md) - audit UI code for WCAG compliance: semantics, keyboard nav, contrast, screen readers.
- [architecture-review-prompt.md](architecture-review-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - audit architecture with evidence-backed 0-10 scores, file:line findings, and a prioritized refactoring roadmap.
- [codebase-audit-prompt.md](codebase-audit-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - audit a codebase as a senior architect: evidence-backed 0-10 scores, structural smell identification, and a prioritized refactoring roadmap.

## Adding a prompt here

Read [CONTRIBUTING.md](../CONTRIBUTING.md) for the file format and the gates,
model the new file on a neighbor in this folder, and add a one-line entry
above plus a [CHANGELOG.md](../CHANGELOG.md) entry under `[Unreleased]`.
