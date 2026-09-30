# Reusable prompt: CSV & spreadsheet wrangling

Copy-paste the block below into any AI coding agent to clean and load a messy
CSV or spreadsheet export without silently corrupting or dropping data.

Keywords: csv, spreadsheet, excel, data wrangling, parsing, messy data, pivot

---

Load and clean the spreadsheet/CSV data described in this task. Messy exports
are where most data projects actually start; the goal is a validated dataset
plus a report of everything that had to be fixed or rejected, not a script
that just runs without erroring.

## Steps

1. **Detect encoding before parsing** - Don't assume UTF-8. Sniff the byte
   order mark (Excel loves UTF-16 with a BOM on Windows exports) and fall
   back through common encodings (UTF-8, UTF-8-SIG, Windows-1252, UTF-16)
   rather than guessing once and hoping.
2. **Infer types, but make overrides explicit** - Auto-detect column types
   (int, float, date, bool, string) from a sample, then let the caller
   override any column by name. Never silently coerce a column that fails
   inference on some rows; flag it instead of picking a lossy fallback type.
3. **State deduplication and fuzzy-matching rules up front** - Decide and
   document the dedup key(s), whether matching is exact or fuzzy (and the
   similarity threshold if fuzzy), and which duplicate is kept when rows
   conflict. Don't dedupe silently with an undocumented rule.
4. **Validate every row, don't just parse it** - Enforce required columns,
   type ranges, and referential rules (e.g. foreign key exists in a lookup).
   Route failing rows to a quarantine set with a reason per row; never drop a
   row without recording why.
5. **Produce a validation report** - Row counts in, accepted, quarantined,
   and deduplicated, plus a breakdown of quarantine reasons. This is the
   artifact a human actually checks; a clean exit code alone proves nothing.
6. **Round-trip test before trusting the pipeline** - Write the cleaned data
   back out and re-read it; confirm values, types, and row count survive the
   round trip unchanged (watch especially for date/timezone drift, leading
   zeros in ID-like strings, and float precision).

## Rules

- Silent data loss is the cardinal sin: every dropped, coerced, or
  deduplicated row must be counted and explained in the report.
- Never assume the input encoding or delimiter; detect both, and fail loudly
  (not with a mis-parsed but "successful" load) when detection is ambiguous.
- If a column's real-world meaning makes an inference rule unsafe (e.g.
  leading-zero IDs read as integers), say so explicitly rather than silently
  "fixing" it.
