# Reusable prompt: prompting, RAG, or fine-tuning

Copy-paste the block below into any AI coding agent to choose the cheapest LLM
technique that is good enough for `[the use case]`, justify it with a scored
decision matrix backed by evidence, and state what would later prove the choice
wrong.

Keywords: prompting, rag, fine tuning, decision matrix, model cost

---

Decide whether `[the use case]` in this repository needs better prompting,
retrieval-augmented generation (RAG), a fine-tuned model, or nothing at all.
Deliver the requirement analysis, a scored matrix with evidence per option, an
eval plan that tests the chosen option on a real set, and the criteria that
would reverse the decision.

## Steps

1. **Requirements before options** - Freshness (daily, weekly, never),
   specificity (corpus or private), output format and style, a quality bar with
   a failure definition, a latency target, volume, tokens, a cost budget, and
   data sensitivity.
2. **Score the matrix** - Rows are prompting, RAG, and fine-tuning; columns are
   step 1's requirements. Score each cell strong, weak, or not viable, attach
   evidence (a citation, a price, a latency) and state the weights.
3. **Cheapest sufficient first** - Prompting first (hours), RAG next (days, an
   index to keep), fine-tuning last (weeks, curation, retraining). Test the
   cheapest against the quality bar; name what it makes worse.
4. **Eval on real inputs** - Build at least 30 real inputs first: common, edge,
   and known-failure cases. Keep a held-out split untouched to the final run,
   fix thresholds first, score every candidate on one set.
5. **Reversal criteria** - Name what would switch it: a named quality gap
   prompting cannot close, a retrieval recall ceiling, a latency target it
   cannot meet, or a cost the team cannot carry, each with metric, threshold,
   and owner. Add eval results, cost, latency, and a review date.

## Verification

- [ ] The requirement list is pasted, with freshness, specificity, quality bar,
      latency, volume, cost, and sensitivity all covered.
- [ ] The scored matrix has evidence attached to every cell, unverified cells
      marked, and the column weights stated.
- [ ] The cheapest sufficient option was tested first and recorded if it
      cleared the bar.
- [ ] The held-out split was scored once, with baseline and chosen option on
      the same set and the cost and latency delta shown.
- [ ] The reversal criteria carry metric, threshold, and decision owner, and a
      review date is set.

## Rules

- Never fine-tune to add knowledge you could retrieve. Training data is a
  snapshot; retrieval stays current and auditable.
- No option enters the matrix without evidence for its cells. Mark unknown as
  unknown and say what experiment would resolve it.
- The eval set is built before the system, and the held-out split is scored
  once.
- Report cost and latency per option next to quality. Cheapest sufficient wins;
  sufficient is defined by the thresholds you set first.
- If two options score equally, take the one you can undo in a day.
