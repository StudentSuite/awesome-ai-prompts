# Reusable prompt: CSV & spreadsheet wrangling

Copy-paste the block below into any AI coding agent to clean and load a messy
CSV or spreadsheet export without silently corrupting or dropping data.

Keywords: csv, spreadsheet, excel, data wrangling, parsing, messy data, pivot

---

Load and clean the spreadsheet/CSV data described in this task. Messy exports
are where most data projects actually start; the goal is a validated dataset
plus a report of everything that had to be fixed or rejected, not a script that
just runs without erroring.

## Steps

1. **Detect encoding before parsing** - Do not assume UTF-8. Sniff the byte
   order mark (Windows exports are often UTF-16 with a BOM) and fall back
   through UTF-8, UTF-8-SIG, Windows-1252, and UTF-16 rather than guessing
   once.
2. **Infer types, but make overrides explicit** - Auto-detect column types from
   a sample, then let the caller override any column by name. Never silently
   coerce a column that fails inference on some rows; flag it instead of
   picking a lossy fallback.
3. **State dedup and fuzzy-match rules up front** - Document the dedup key(s),
   whether matching is exact or fuzzy (and the threshold), and which duplicate
   survives when rows conflict. Never dedupe under an undocumented rule.
4. **Validate every row, don't just parse it** - Enforce required columns, type
   ranges, and referential rules. Route failures to a quarantine set with a
   per-row reason; never drop a row without recording why.
5. **Produce a validation report** - Rows in, accepted, quarantined, and
   deduplicated, plus a breakdown of quarantine reasons. This is the artifact a
   human actually checks; a clean exit code proves nothing.
6. **Round-trip before trusting the pipeline** - Write the cleaned data out and
   re-read it, confirming values, types, and row count survive unchanged. Watch
   date and timezone drift, leading zeros in ID-like strings, and float
   precision.

## Verification

- [ ] The encoding and delimiter were detected rather than assumed, and an
      ambiguous detection failed loudly instead of mis-parsing.
- [ ] Every dropped, coerced, or deduplicated row is counted and explained in
      the report.
- [ ] Quarantined rows carry a per-row reason; none were dropped silently.
- [ ] Leading-zero IDs, date and timezone drift, and float precision were each
      checked specifically.
- [ ] Cleaned data was written and re-read, with values, types, and row count
      identical after the round trip.

## Rules

- Silent data loss is the cardinal sin: every dropped, coerced, or deduplicated
  row must be counted and explained in the report.
- Never assume the input encoding or delimiter; detect both, and fail loudly
  (not with a mis-parsed but "successful" load) when detection is ambiguous.
- If a column's real-world meaning makes an inference rule unsafe (e.g.
  leading-zero IDs read as integers), say so explicitly rather than silently
  "fixing" it.
