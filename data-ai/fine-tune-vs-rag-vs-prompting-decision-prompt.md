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

1. **Write the requirements before the options** - State what the feature must
   do: knowledge freshness (daily, weekly, or never), domain specificity (in the
   pretraining corpus or private to this business), output format and style
   constraints, a quality bar with a concrete failure definition, a latency
   target, request volume and token estimates, a unit cost budget, data
   sensitivity, and who owns maintenance.
2. **Score the options against a matrix** - Rows are prompting (better
   instructions, few-shot examples, structured output), RAG (retrieve known
   context at query time), and fine-tuning (train on curated examples or a
   preference set). Columns are the requirements from step 1. Score each cell
   strong, weak, or not viable and attach evidence: a citation, a vendor
   capability, a price, a measured latency, a small experiment. Weight and state
   the columns. A matrix with no evidence is an opinion; mark unverified cells.
3. **Start with the cheapest thing that could work** - By cost and time:
   prompting first (hours, no new infrastructure), RAG next (days, indexing to
   maintain), fine-tuning last (weeks, curation, retraining loop, a model to
   serve). Check the cheapest option against the quality bar honestly. If
   prompting clears the bar, stop and record that. Escalate only when the
   cheaper option fails for a reason the other fixes.
4. **Predict the tradeoffs of each choice** - Write down what the chosen option
   costs and what it makes worse: latency and tokens for RAG, curation and
   forgetting risk for fine-tuning, prompt fragility across model versions for
   prompting. Include the ongoing maintenance burden and the numbers you expect.
5. **Design an eval that could prove the choice wrong** - Build a representative
   set of real inputs before building anything (at least 30: common case, edge
   cases, known past failures, and inputs the designers did not imagine). Keep a
   held-out split untouched until the final run. Define pass criteria and
   thresholds in advance. Score the baseline and each candidate on the same set
   with the same settings, over multiple runs when outputs vary.
6. **Document the reversal criteria** - Before building, write down what would
   make you switch: a named quality gap prompting cannot close, a retrieval
   recall ceiling, a volume or latency target one option cannot meet, a data
   sensitivity rule that forbids sending context to the model, or a maintenance
   cost the team cannot carry. Attach the metric, threshold, and decision owner.
7. **Record the decision and review date** - Write a short decision doc:
   requirements, matrix, chosen option, predicted tradeoffs, eval results, the
   rejected options with reasons, and reversal criteria. Include the cost and
   latency model. Set a review date and note which matrix cells are assumptions
   to re-check as the model or corpus changes.

## Rules

- Never fine-tune to add knowledge you could retrieve. Training data is a
  snapshot; retrieval stays current and auditable.
- No option enters the matrix without evidence for its cells. Mark unknown as
  unknown and say what experiment would resolve it.
- The eval set is built before the system, and the held-out split is scored
  once.
- Report cost and latency per option next to quality. Cheapest sufficient
  wins; sufficient is defined by the thresholds you set first.
- If two options score equally, take the one you can undo in a day.

## Verification

Paste the requirement list, the scored matrix with the evidence attached to
each cell and the weights stated, the baseline-versus-chosen-option results on
the held-out split with cost and latency, and the reversal criteria.
