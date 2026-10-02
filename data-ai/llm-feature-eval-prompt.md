# Reusable prompt: LLM feature evaluation

Copy-paste the block below into any AI coding agent to evaluate an LLM-powered
feature rigorously - with a test set, defined metrics, and pass thresholds
decided before looking at results.

Keywords: llm eval, evaluation, benchmark, eval set, quality regression, scoring

---

Evaluate the LLM-powered feature in this repository (or a proposed prompt or
model change). Goal: replace "looks fine to me" with repeatable measurements.

## Steps

1. **Define what "good" means** - With the feature owner, pick 3-5 measurable
   criteria (correct extraction vs source, valid JSON schema adherence, refusal
   when information is missing, tone/length bounds). Binary or rubric-scored,
   not vibes.
2. **Build the test set** - 30+ representative cases including adversarial
   ones: empty/noisy input, injection attempts, ambiguous requests,
   multilingual input if supported, and known past failures. Store as versioned
   fixtures.
3. **Automate scoring** - Deterministic checks in code (schema validation,
   exact-match fields, citation presence); model-graded rubrics only where
   necessary, with the rubric shown in the output for auditability.
4. **Run baseline and variants** - Score the current prompt/model, then each
   candidate change. Same test set, same settings, multiple runs where outputs
   are stochastic - report mean and worst case.
5. **Analyze failures, not averages** - Cluster failing cases by cause (prompt
   ambiguity, missing context, model limitation). Fix causes in prompt,
   retrieval, or code; note which failures are inherent and need product
   guardrails instead.
6. **Report honestly** - Table of variants by criteria with pass rates, a
   regression list, cost/latency deltas, and a recommendation with tradeoffs
   named.

## Verification

- [ ] 3-5 measurable criteria were fixed with the feature owner, scored binary
      or by rubric rather than by impression.
- [ ] Pass thresholds were set before results were seen.
- [ ] The set holds 30+ representative and adversarial cases as versioned
      fixtures, with a held-out split never used for tuning.
- [ ] Every run logs model, version, and prompt hash, so results can be
      reproduced.
- [ ] Failures are clustered by cause, and the report gives pass rates per
      criterion, the regression list, and cost and latency deltas.

## Rules

- Decide pass thresholds before running; changing them after seeing results is
  forbidden.
- Never evaluate on the same examples you tuned prompts against - keep a
  held-out split.
- Log model/version/prompt hash with every run so results are reproducible.
