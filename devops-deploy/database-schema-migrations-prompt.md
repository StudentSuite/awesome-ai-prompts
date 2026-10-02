# Reusable prompt: database schema & migrations

Copy-paste the block below into any AI coding agent to design or evolve a
database schema safely - backward-compatible migrations and a clean rollout.

Keywords: schema migration, zero downtime, backfill, rollback, alter table, deploy safely

---

Design/update the database schema for `[feature/change]` in this repository and
write the migrations. Treat the schema like a public API: changes must be
backward-compatible unless the migration plan explicitly says otherwise.

## Steps

1. **Understand the data** - Read the schema, models, and the code that reads
   and writes this data: current constraints, indexes, and how queries are
   really made. Don't design in a vacuum.
2. **Design the change** - Minimal and consistent with existing naming.
   Cover types, nullability, defaults, indexes for the real query patterns,
   constraints, and referential integrity.
3. **Write backward-compatible migrations** - Use the framework the repo
   already uses (Alembic, Prisma, Django, Knex, Flyway). Old code must keep
   working against the new schema, so split the change into **Expand** (add
   nullable or defaulted columns and tables), **Migrate data** (backfill in a
   separate transaction), and **Contract** (drop old columns and tables, often
   in a later migration). The down migration must safely reverse the up
   migration.
4. **Flag the classic failures** - Adding `NOT NULL` to a populated table,
   renaming a column (use add + migrate + drop), changing a type that breaks
   comparisons, or indexing a big table and locking it.
5. **Verify** - Run the migration up and down against a local database, run
   the test suite, and confirm both old and new code paths work on the
   migrated schema.

## Verification

- [ ] The migration is backward-compatible: the old and new application
      versions both run against it.
- [ ] Destructive changes are split into expand, migrate, and contract phases,
      each separately reversible.
- [ ] The classic hazards are handled explicitly: adding `NOT NULL` to
      populated tables, adding indexes on large tables, and renaming columns.
- [ ] The migration ran up and down against a local database, with both outputs
      shown.
- [ ] Application-level checks were written alongside the schema change, and
      each migration makes one logical change only.

## Rules

- Never write a migration that drops or renames data without a stated, approved
  plan.
- Never run destructive migrations against a real database without explicit
  confirmation.
- Keep each migration focused on one logical change.
- If the schema change can't be made backward-compatible, stop and flag the
  coordination needed instead of hiding it.
