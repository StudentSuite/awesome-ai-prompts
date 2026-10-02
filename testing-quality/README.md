# Testing & quality

Prompts for finding bugs and proving behavior: test writing, coverage, end-to-end flows, and deliberate failure injection.

Prompts carrying the light-blue badge are the heavyweight
[spec](../README.md#testing--quality) prompts: multi-section, with
hard constraints and required verification.

Back to the [main index](../README.md#testing--quality) or browse
[every prompt on one page](../ALL_PROMPTS.html).

## Prompts

- [bug-finder-prompt.md](bug-finder-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - sweep a codebase across correctness factors and get a clear, evidence-backed, priority-ordered list of bugs.
- [bug-finder-with-docs-prompt.md](bug-finder-with-docs-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - find bugs and leave a durable bug ledger behind: a priority-ordered report plus BUGS.md and README pointers, with the code untouched.
- [test-writing-prompt.md](test-writing-prompt.md) - write tests that catch regressions, not ones that pad coverage.
- [test-driven-development-prompt.md](test-driven-development-prompt.md) - strict red → green → refactor discipline.
- [code-coverage-gap-prompt.md](code-coverage-gap-prompt.md) - find risky untested paths and cover them meaningfully.
- [e2e-test-scaffold-prompt.md](e2e-test-scaffold-prompt.md) - scaffold end-to-end/integration tests with realistic fixtures and CI integration.
- [mutation-testing-prompt.md](mutation-testing-prompt.md) - run mutation testing to validate that tests actually catch real defects.
- [contract-testing-prompt.md](contract-testing-prompt.md) - consumer-driven contract tests so API drift fails CI, not production.
- [chaos-resilience-prompt.md](chaos-resilience-prompt.md) - inject failures and close the gaps: timeouts, backoff, graceful degradation.

- [property-based-testing-prompt.md](property-based-testing-prompt.md) - write property-based tests with generated inputs and shrink evidence.$
## Adding a prompt here

Read [CONTRIBUTING.md](../CONTRIBUTING.md) for the file format and the gates,
model the new file on a neighbor in this folder, and add a one-line entry
above plus a [CHANGELOG.md](../CHANGELOG.md) entry under `[Unreleased]`.
