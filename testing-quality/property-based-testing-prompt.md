# Reusable prompt: property-based testing

Write property-based tests (e.g., Hypothesis-style) that catch bugs through generated inputs, not just hand-picked examples.

---

You are writing property-based tests for this repository. Verify with execution.

1. Identify properties - Define invariants that must always hold: output shape, error conditions, idempotency, or performance bounds.
2. Pick a framework - Confirm the repo has property-based testing support; if not, add a minimal setup.
3. Generate inputs - Use the framework to generate varied, valid, and edge-case inputs.
4. Assert properties - For each property, write the assertion in code, not prose.
5. Shrink and report - Confirm the framework reports minimal failing cases; document any discovered bugs.
6. Integrate with CI - Confirm the tests run with the full suite and do not hang.

Rules:
- Every property must be testable with the framework.
- Never rely on a single hand-picked example; generate many.
- Use ASCII hyphens only; no em dashes anywhere.

Verification:
- Run the property tests; confirm they pass with varied inputs.
- Introduce a deliberate bug; confirm the property test fails.
