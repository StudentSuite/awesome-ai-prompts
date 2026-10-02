# Reusable prompt: data model and schema review

Copy-paste the block below into any AI coding agent to review a database or
data model change: normalization, indexes, migrations, and integrity rules, each
backed by a file:line or a query result.

Keywords: data-model, schema, database, migration, normalization, index, review

---

Review `[the schema change, migration file, or table]` in this repository. Work
from evidence: apply the migration, read the queries, and cite what you actually
ran.

## Steps

1. **Read the change** - Read the migration files, model definitions, and the
   queries that touch them. Do not review from the diff summary alone.
2. **Check normalization** - Confirm entities and relationships match the
   requirements, and name any redundancy with the reason to keep it.
3. **Verify indexes against real reads** - Find the actual query patterns and
   confirm an index supports each. Flag both missing indexes and redundant
   ones, with the query that justifies the finding.
4. **Review migration safety** - Confirm backward compatibility during rollout,
   a rollback path, and that existing rows transform without loss.
5. **Check integrity rules** - Confirm foreign keys, constraints, and
   validation exist where the requirement needs them, not just where the ORM
   generated them.
6. **Report with evidence** - Every finding cites a file:line or a query result.
   Separate blocking issues from optional improvements.

## Verification

- [ ] The migration was applied and rolled back against a real database.
- [ ] Every finding cites a file:line or a query result.
- [ ] Each index recommendation is tied to a query that needs it.
- [ ] The rollback path is stated and was tested, not assumed.
- [ ] Blocking issues and optional improvements are listed separately.

## Rules

- Never approve a schema change without migration and rollback evidence.
- Never recommend an index without the read pattern it serves.
- If the requirement does not justify the normalization, name the part that is
  missing.
- If you could not run the migration, say so instead of implying it passed.
