# Reusable prompt: architecture decision record

Copy-paste the block below into any AI coding agent to turn a real technical
decision into an Architecture Decision Record (ADR) that future teammates
will actually understand.

Keywords: adr, architecture decision record, decision log, tradeoffs, rfc, documenting decisions

---

Write an ADR for a decision made (or being made) in this repository. The goal
is a short, factual record of what was decided, why, and what alternatives
were rejected - readable in two minutes by someone with no context.

## Steps

1. **Identify the decision** - Pin down exactly what was decided and when.
   Read the relevant code, config, and docs first so the ADR matches reality,
   not intention.
2. **Gather context** - What problem forced this decision? What constraints
   applied (team, deadline, stack, cost)? Cite evidence: issues, PRs, code.
3. **List considered options** - At least two real alternatives plus the
   chosen one. For each: one-line summary, pros, cons.
4. **Justify the choice** - Why this option won given the context. Be
   specific: "Postgres because we need transactions and already run it"
   beats "it's industry standard".
5. **Record consequences** - What becomes easier, what becomes harder, what
   new obligations follow (migrations, runbooks, license costs).
6. **Number and file it** - Follow the repo's existing ADR convention if
   there is one (`docs/adr/`, `adr/`); otherwise propose `docs/adr/NNNN-title.md`
   with the next free number.

## Output

One ADR file with this structure: Title, Status (proposed/accepted/
superseded), Context, Decision, Options considered, Consequences. Keep it
under ~100 lines.

## Rules

- Describe the decision as made, not as you wish it had been made.
- No rewriting history: if a decision looks wrong today, note it as a
  candidate for a superseding ADR instead of editing the old one.
- Every claim about the codebase must be verified against the actual code.
