# Reusable prompt: datetime & timezone correctness

Copy-paste the block below into any AI coding agent to handle dates and
times correctly instead of shipping the timezone bug that only shows up in
production, months later.

Keywords: datetime, timezone, utc, daylight saving, clock skew, timestamps, off by one

---

Review or implement the datetime handling in this task. Timezone bugs are
among the most common production defects and are almost never caught by a
"looks right on my machine" check; treat every date/time value as a trap
until proven otherwise.

## Steps

1. **Store UTC, render local, always** - Persist and pass around timestamps
   in UTC (or a fixed offset like Unix epoch millis); convert to the user's
   local timezone only at the display/render boundary. Never store a
   "local" timestamp without its offset.
2. **Handle DST transitions explicitly** - Identify any logic that adds
   durations to a local time (e.g. "add 1 day") and confirm it survives a
   spring-forward/fall-back transition; use timezone-aware date-math
   libraries rather than naive arithmetic on wall-clock time. Flag
   ambiguous local times (the repeated hour during fall-back) instead of
   picking one silently.
3. **Parse untrusted date input defensively** - Never trust an
   unconstrained free-text date format from users or external APIs; validate
   against expected formats, reject or explicitly flag ambiguous inputs
   (e.g. `01/02/2026`, day-first vs month-first), and record the assumed
   timezone when the input doesn't specify one.
4. **Get durations and calendar math right** - Distinguish elapsed duration
   (a fixed number of seconds) from calendar duration ("add 1 month", which
   varies in length); use business-day math (skipping weekends/holidays)
   only where explicitly required, and state which holiday calendar applies.
5. **Write property tests around clock changes** - Test date-math functions
   across a DST boundary, a leap year/leap second edge, a month-end rollover
   (Jan 31 + 1 month), and a UTC offset that isn't a whole hour (e.g.
   India's UTC+5:30) - these are exactly the cases naive implementations get
   wrong.

## Rules

- Never format or compare a "naive" datetime (no timezone attached) against
  a timezone-aware one; make the mismatch a type error where the language
  allows it.
- Never hardcode a specific timezone offset as a constant; timezones and
  their offsets change (DST rules, political redefinitions) - use a
  timezone database, not a fixed number.
- If a date's true intended timezone is ambiguous from context, ask or
  document the assumption instead of guessing UTC vs local silently.
