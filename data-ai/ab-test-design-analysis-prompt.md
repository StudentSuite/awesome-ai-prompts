# Reusable prompt: A/B test design and analysis

Copy-paste the block below into any AI coding agent to design and read an
online experiment so the result is trustworthy: hypothesis, metric, and stopping
rule fixed before launch, and an effect size with an interval rather than a bare
p-value.

Keywords: ab testing, experiment design, sample size, randomization, effect size

---

Design and analyze `[the change being tested]` in this repository. The output is
a written experiment plan plus the analysis code, so that a reader can tell
whether the result means the change shipped or whether the test was simply too
small. Decide every rule before collecting data.

## Steps

1. **Write the hypothesis as one falsifiable sentence** - State the change, the
   population, and the metric with an expected direction. Name the primary
   metric (exactly one), the guardrail metrics that must not regress (latency,
   errors, support tickets, retention), and the minimum effect worth shipping.
   Anything measured but not pre-declared is exploratory and may not drive the
   decision.
2. **Fix the unit and the population** - Choose the randomization unit: user,
   account, household, or session. Explain why, and what breaks if the wrong
   entity is randomized. State the eligibility rules, exclusions before
   assignment, and the analysis population. Log the assignment itself.
3. **Compute sample size and duration** - From a baseline rate and the minimum
   detectable effect, compute per-arm sample size at 80% power and 95%
   confidence, showing the formula inputs. Convert to wall-clock duration using
   observed daily traffic and the day-of-week cycle; if that runs past any
   plausible release window, say so and cut scope before launching.
4. **Check for contamination and interference** - Look for shared accounts,
   multi-device logins, cross-device identifiers, referral and collaboration
   paths that expose one arm to the other, and caches that leak the treatment.
   Decide the stickiness rule and add an analysis that measures overlap between
   arms. If exposure cannot be verified, label the test observational.
5. **Pre-register the analysis and the stopping rule** - Fix the test
   statistic, the significance threshold, the multiple-comparison handling, and
   the stopping rule (fixed horizon, or a sequential design with planned
   boundaries). Commit exclusions and analysis code before the first user is
   exposed. No peeking and stopping on the first p below threshold.
6. **Instrument and validate the run** - Emit exposure and outcome events, then
   sanity-check the first slice: sample ratio mismatch between arms, assignment
   counts, event volume, and covariate balance. A sample ratio mismatch is a
   broken run, not a finding.
7. **Analyze and report effect sizes** - Report per-arm counts, absolute and
   relative effect, a confidence interval, and the p-value as a secondary
   number. Guardrails get the same treatment. Run the pre-registered analysis
   code, then check robustness (another interval method, leave-one-segment-out,
   behavior change over the run) to see whether one segment or one day drives
   the effect.
8. **Decide and document** - Ship, ship with caveats, iterate, or stop, against
   the pre-declared rule. Write up the hypothesis, the numbers, the caveats, and
   the follow-up, and state whether the interval excluded the null as declared
   or the test was underpowered.

## Rules

- No decision on a p-value alone. Effect size and interval are the result; the
  p-value is a footnote.
- Changing the primary metric, the stopping rule, or the exclusions after
  exposure invalidates the test. Say so explicitly if it happens.
- Guardrail regressions block the ship even when the primary metric improves.
- If sample size is insufficient for the pre-declared effect, report it as
  inconclusive and do not reinterpret direction as evidence.
- One experiment, one decision. Splitting results by segment after the fact is
  exploration, and each subgroup needs its own pre-declared test later.

## Verification

Paste the pre-registered plan with its commit and date, the power calculation
inputs, the per-arm exposure counts, the sample ratio check, and the results
table with absolute effect, relative effect, interval, and p-value. Include the
guardrail table and the robustness checks.
