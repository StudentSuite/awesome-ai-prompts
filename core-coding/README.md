# Core coding

Prompts for writing, changing, and debugging code in an existing repository: features, refactors, APIs, schemas, and errors.

Prompts carrying the light-blue badge are the heavyweight
[spec](../README.md#core-coding) prompts: multi-section, with
hard constraints and required verification.

Back to the [main index](../README.md#core-coding) or browse
[every prompt on one page](../ALL_PROMPTS.html).

## Prompts

- [feature-implementation-prompt.md](feature-implementation-prompt.md) - build a feature end-to-end: understand, plan, implement, test, document.
- [pair-programming-session-prompt.md](pair-programming-session-prompt.md) - interactive build loop: plan → code → explain → verify, in small confirmed steps.
- [debugging-prompt.md](debugging-prompt.md) - systematic debugging: reproduce, isolate, root-cause, minimal fix, regression test.
- [refactoring-prompt.md](refactoring-prompt.md) - behavior-preserving refactoring with tests as the safety net.
- [human-codebase-onboarding-prompt.md](human-codebase-onboarding-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - understand an unfamiliar repo at verification depth: stack, architecture, data flow, conventions, gotchas, with file:line evidence.
- [agent-codebase-onboarding-prompt.md](agent-codebase-onboarding-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - onboard an agent into an unfamiliar repo with no human in the loop: a token-budgeted protocol, a compact in-context model, and required verification.
- [api-integration-prompt.md](api-integration-prompt.md) - integrate a REST API with types, error handling, retries, and tests.
- [api-design-prompt.md](api-design-prompt.md) - design a well-structured REST API with OpenAPI spec, conventions, and validation.
- [database-design-prompt.md](database-design-prompt.md) - model a relational schema from requirements with normalization, indexes, and migration path.
- [environment-setup-prompt.md](environment-setup-prompt.md) - bootstrap a dev environment from scratch: deps, tooling, config, first-run verification.
- [code-migration-prompt.md](code-migration-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - migrate code between frameworks/languages with behavior parity and incremental verification.
- [cli-tool-build-prompt.md](cli-tool-build-prompt.md) - build a well-behaved CLI: documented flags, typed exit codes, safe pipe and TTY handling, testable core.
- [datetime-timezone-correctness-prompt.md](datetime-timezone-correctness-prompt.md) - store UTC render local, handle DST, and get calendar/duration math right.
- [error-handling-strategy-prompt.md](error-handling-strategy-prompt.md) - one coherent error policy: typed errors, context-rich logs, retry vs surface, proven by failure injection.
- [regular-expressions-prompt.md](regular-expressions-prompt.md) - write or repair a regex with a stated purpose, a test corpus, and a check that it cannot hang on adversarial input.

- [file-uploads-media-handling-prompt.md](file-uploads-media-handling-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - take uploads that survive hostile files, traversal, and unreliable networks: server-side validation, streaming, safe storage names, resumable transfers.

- [graphql-api-design-prompt.md](graphql-api-design-prompt.md) - design a GraphQL schema that scales past the demo: batching over N+1, field-level authz, bounded complexity, stable error shape.

- [websockets-realtime-features-prompt.md](websockets-realtime-features-prompt.md) - build realtime that survives disconnects and horizontal scaling: lifecycle, message contract, stated delivery guarantee, slow-client policy.

- [payment-integration-prompt.md](payment-integration-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - add payments with money-grade discipline: no raw card data, idempotent mutations, verified webhooks, reconciliation.

- [email-delivery-prompt.md](email-delivery-prompt.md) - send transactional mail that lands: domain authentication, code templates, async retries, bounce and complaint handling.

## Adding a prompt here

Read [CONTRIBUTING.md](../CONTRIBUTING.md) for the file format and the gates,
model the new file on a neighbor in this folder, and add a one-line entry
above plus a [CHANGELOG.md](../CHANGELOG.md) entry under `[Unreleased]`.
