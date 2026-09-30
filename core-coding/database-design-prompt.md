# Reusable prompt: database design

Copy-paste the block below into any AI coding agent to model a relational
database schema from requirements - normalized, indexed, and ready for
migration.

Keywords: database design, schema, tables, normalization, indexes, data model

---

Design a database schema for `[feature / domain]`. The goal: a clean,
normalized data model that supports the required queries without over-engineering.

## Steps

1. **Understand the requirements** - Read the feature spec, existing data
   models, and any current database schemas in the codebase. Identify the
   entities, their attributes, and relationships (one-to-one, one-to-many,
   many-to-many). Do not design tables that duplicate what already exists.
2. **Define tables and columns** - Name tables and columns consistently with
   the existing codebase conventions (snake_case, singular/plural). Choose
   appropriate data types and nullable vs required constraints. Include
   `created_at`/`updated_at` timestamps where the repo uses them.
3. **Set up relationships** - Define foreign keys, junction tables for
   many-to-many relationships, and ON DELETE/UPDATE behavior. Ensure referential
   integrity at the database level, not just in application code.
4. **Plan indexes** - Identify columns used in WHERE, JOIN, and ORDER BY
   clauses. Add indexes for expected query patterns. Avoid over-indexing:
   every index has a write cost.
5. **Normalize appropriately** - Apply normalization (3NF) to eliminate
   redundancy, but denormalize deliberately where read performance requires it
   (and document the trade-off).
6. **Write the migration** - Produce a migration script that creates the schema
   incrementally: CREATE TABLE, then ALTER for foreign keys and indexes. Follow
   the repo's existing migration tooling and conventions.
7. **Verify** - Run the migration against a test database. Confirm the tables
   create cleanly, constraints fire correctly, and sample queries work.

## Rules

- Never drop or rename columns in a migration without a backward-compatible
  expand-migrate-contract plan.
- Never add indexes on every column "just in case" - prove the query pattern
  needs it.
- If the existing schema has conventions (naming, soft deletes, audit columns),
  follow them exactly.
- Do not design for scale you don't need yet - a clean schema beats a
  prematurely optimized one.
