# Reusable prompt: data pipeline construction

Copy-paste the block below into any AI coding agent to build an ETL/data
pipeline that survives bad input, reruns, and schema drift - and proves its
output is correct.

Keywords: data pipeline, etl, ingestion, batch job, orchestration, scheduled job

---

Build the requested data pipeline (extract, transform, load) in this
repository. Pipelines fail quietly; yours must fail loudly, resume cleanly, and
make correctness checkable at every stage.

## Steps

1. **Define contracts first** - Source schema(s), destination schema, and the
   transformation rules between them. Write them down (types, nullability,
   ranges) before writing code.
2. **Extract defensively** - Handle pagination, retries, and rate limits on
   APIs; stream large sources instead of loading whole datasets; record what
   was read (counts, watermarks/cursors).
3. **Validate input** - Check row counts against expectations, enforce the
   schema on arrival, quarantine bad records with reasons instead of crashing
   or silently dropping them. Report quarantined volume.
4. **Transform deterministically** - Pure functions where possible; no hidden
   state; unit-test tricky transformations with edge cases (nulls, duplicates,
   timezone boundaries, empty inputs).
5. **Load idempotently** - Running the pipeline twice must not duplicate or
   corrupt data (upserts, staging tables plus swap, or transactional loads).
6. **Make it observable and restartable** - Log per-stage counts and duration,
   emit a success/failure signal, and support resuming from the last successful
   stage rather than a full redo.
7. **Verify end-to-end** - Run on a sample dataset and assert output matches
   hand-computed expectations; then run the rerun test (same input twice
   produces identical output).

## Verification

- [ ] Source and destination schemas and the transformation rules were written
      down before any code.
- [ ] No path, credential, or URL is hardcoded; each varies per environment.
- [ ] Quarantined rows are counted and reported per stage, and per-stage counts
      and duration are logged.
- [ ] Running the pipeline twice produces identical output, with no duplicated
      or corrupted rows.
- [ ] Sample-dataset output matched hand-computed expectations, and the full
      suite passes.

## Rules

- Silent data loss is the cardinal sin: every dropped or quarantined row must
  be counted and reported.
- Hardcode nothing that varies per environment (paths, credentials, URLs).
- If source data quality makes guarantees impossible, say exactly what you can
  and cannot promise.
