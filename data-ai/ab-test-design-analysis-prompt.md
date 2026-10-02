# Reusable prompt: A/B test design and analysis

Copy-paste the block below into any AI coding agent to design and read an
online experiment so the result is trustworthy: hypothesis, metric, and
stopping rule fixed before launch, and an effect size with an interval rather
than a bare p-value.

Keywords: ab testing, experiment design, sample size, randomization, effect size

---

Design and analyze `[the change being tested]` in this repository. The output
is a written experiment plan plus the analysis code, so that a reader can tell
whether the result means the change shipped or whether the test was simply too
small. Decide every rule before collecting data.

## Steps

1. **State the hypothesis and guardrails** - One falsifiable hypothesis:
   change, population, single primary metric, expected direction. Guardrails
   that must not regress (latency, errors, support, retention). The minimum
   effect worth shipping. Anything not pre-declared is exploratory.
2. **Fix unit, size, and duration** - Choose randomization unit (user, account,
   household, session). State eligibility, exclusions, and log assignment.
   Compute per-arm sample size at 80% power, 95% confidence from baseline rate
   and MDE. Convert to duration using observed traffic. If it runs past a
   plausible window, cut scope.
3. **Pre-register before exposure** - Test statistic, significance threshold,
   multiple-comparison handling, and stopping rule. Commit exclusions and
   analysis code before first exposure. No peeking.
4. **Validate and decide** - Emit exposure and outcome events, then check
   sample ratio mismatch, assignment counts, event volume, and covariate
   balance. Report primary, absolute/relative effect, interval, and p-values
   for guardrails. Run robustness checks and decide ship, caveat, iterate, or
   stop per the pre-declared rule, stating whether the interval excluded the
   null.

## Verification

- [ ] The pre-registered plan is pasted with its commit and date.
- [ ] The power calculation inputs are shown, with the resulting per-arm
      duration.
- [ ] The primary metric is exactly one, and every other reported metric is
      labeled exploratory or guardrail.
- [ ] The per-arm exposure counts and the sample ratio check are shown.
- [ ] The results table carries absolute effect, relative effect, interval, and
      p-value, plus the guardrail table and robustness checks.
- [ ] The verdict names whether the interval excluded the null as declared, or
      the test was underpowered.

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
