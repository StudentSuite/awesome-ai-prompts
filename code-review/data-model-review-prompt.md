# Reusable prompt: data model and schema review

Review a database or data model change: normalization, indexes, migrations, and verification steps, with evidence.

---

You are reviewing a data model or schema change. Work with evidence.

1. Read the schema - Read migration files, model definitions, and any related queries.
2. Check normalization - Confirm entities and relationships match the requirements; identify redundancy.
3. Verify indexes - Confirm indexes support the read patterns; check for missing or redundant indexes.
4. Review migrations - Confirm backward compatibility, rollback path, and that old data transforms safely.
5. Check data integrity - Confirm foreign keys, constraints, and validation rules are in place.
6. Provide evidence - Every finding references a file:line or a query result.

Rules:
- Do not approve schema changes without migration and rollback evidence.
- No claims without file:line or query evidence.
- Use ASCII hyphens only; no em dashes anywhere.

Verification:
- Run the migration in a test database; confirm it applies and rolls back cleanly.
