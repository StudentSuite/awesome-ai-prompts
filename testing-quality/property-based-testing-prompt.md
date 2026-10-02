# Reusable prompt: property-based testing

Copy-paste the block below into any AI coding agent to write property-based tests
that catch bugs through generated inputs rather than hand-picked examples, with
every property asserted in code and shrunk to a minimal case on failure.

Keywords: property based testing, fuzzing, generated inputs, hypothesis, invariants, test cases, edge case

---

Write property-based tests for `[the function, endpoint, or parser]` in this
repository. Define the invariants first, assert them in code, and verify with
execution rather than reasoning about what the code probably does.

## Steps

1. **Identify the properties** - Define the invariants that must hold for
   every input: output shape, error behavior, idempotency, or a performance
   bound. Name them before generating anything.
2. **Pick the existing framework** - Check whether the repo has property-based
   testing support. Only add a minimal setup if none exists, and match the
   project's existing test layout.
3. **Generate varied inputs** - Use the framework to generate valid,
   edge-case, and adversarial inputs, constrained to the input domain the code
   actually accepts.
4. **Assert in code** - Write each property as an assertion in the test, not as
   a sentence in a comment.
5. **Shrink and report** - Confirm the framework reports a minimal failing
   case, and file or document every bug it surfaces.
6. **Integrate with CI** - Confirm the new tests run with the full suite, with
   a bounded example count so they cannot hang.

## Verification

- [ ] Every property is asserted in code and checkable by the framework.
- [ ] The tests were run, and they pass across the generated inputs.
- [ ] A deliberate bug was introduced, and the property test caught it.
- [ ] A failing case shrank to a minimal reproducible input.
- [ ] The tests run in CI with a bounded example count and no hang.

## Rules

- Never rely on a single hand-picked example; generate many.
- Never assert a property the framework cannot express or shrink.
- If the input domain is unbounded, constrain generation rather than shrinking
  the test.
- If no property exists yet, find the invariant before writing the test.
