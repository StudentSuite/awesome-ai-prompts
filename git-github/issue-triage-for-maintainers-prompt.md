# Reusable prompt: issue triage for maintainers

Copy-paste the block below into any AI coding agent to turn a backlog of
untriaged issues into labeled, prioritized, answerable queues.

Keywords: issue triage, maintainer, labels, duplicates, prioritization, backlog

---

Triage the open issues in this repository. The goal is a backlog a maintainer
can act on in priority order, not a pile of "looked at it" noise.

## Steps

1. **Check reproducibility first** - Confirm clear repro steps, expected vs
   actual behavior, and environment details. If one is missing, reply naming
   that exact piece (not "please provide more info") and label
   `needs-repro`/`needs-info` rather than guessing.
2. **Detect and link duplicates** - Search open and closed issues for the same
   root cause before triaging as new. Link duplicates to the canonical issue,
   summarize why they match, and close with a pointer rather than leaving both
   open.
3. **Apply one label rubric** - Use the repo's actual label set; if none
   exists, propose one (`severity: blocker/high/medium/low`) instead of ad hoc
   labels, and justify each severity in one line. Label small, well-scoped
   issues needing no deep repo context as `good first issue` and comment with
   the file to start from.
4. **Apply the stale policy** - Follow the repo's stale-bot policy; if none
   exists, propose one (ping after 60 days of no response, close 14 days later)
   and apply it consistently, with a comment saying why and how to reopen.
5. **Summarize the pass** - Report counts by label and severity, the duplicates
   merged, and the issues needing a maintainer decision you cannot make
   (design, breaking changes, roadmap).

## Verification

- [ ] Reproducibility was confirmed for each bug report before it was labeled.
- [ ] Every duplicate links the canonical issue and the reasoning for closing.
- [ ] The repo's own label taxonomy and severity rubric were used, not an
      invented one.
- [ ] Every good-first-issue candidate carries mentoring notes on how to
      approach it.
- [ ] Stale issues follow the repo's stated policy and are labelled, not
      silently closed.
- [ ] Severity that genuinely depends on product judgment was raised as a
      question rather than assumed.
- [ ] The pass is summarized with counts by label and severity and a list
      needing a human decision.

## Rules

- Never close an issue as invalid or duplicate without linking the reasoning or
  the canonical issue - a silent close reads as dismissive and loses context
  for whoever revisits it.
- Don't invent a label taxonomy that ignores one the repo already has; extend
  it, don't fragment it.
- Ask, don't assume, when severity or priority genuinely depends on product
  judgment rather than technical facts.
