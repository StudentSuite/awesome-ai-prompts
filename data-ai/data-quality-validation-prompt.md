# Reusable prompt: data quality and validation contracts

Define data quality rules and validation contracts for a pipeline or dataset: expectations, checks, and failure response.

---

You are defining data quality rules for this repo. Verify with execution.

1. Identify critical fields - List the columns or records that must be correct; define the rules.
2. Choose a framework - Confirm what validation library exists; if none, propose a minimal one.
3. Write contracts - Write validation rules: type, range, uniqueness, nullability, and relationships.
4. Build checks - Implement automated checks that run on new data; reference file:line.
5. Define failure response - Confirm what happens when validation fails: reject, quarantine, or alert.
6. Integrate with pipeline - Confirm checks run at ingestion, not just at analysis time.

Rules:
- Every rule must have an automated test or check backing it.
- No rules without a failure-handling plan.
- Use ASCII hyphens only; no em dashes anywhere.

Verification:
- Introduce invalid data; confirm the check catches it.
- Confirm valid data passes all checks in CI.
