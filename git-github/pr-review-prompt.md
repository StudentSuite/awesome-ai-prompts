# Reusable prompt: pull request review [spec]

Copy-paste the block below into any AI coding agent to get a structured,
evidence-driven pull request review that prioritises correctness over
comment volume.

Keywords: pull request review, code review, feedback, approve, merge, diff

---

Review `[the PR, branch, or diff range]` in this repository as a senior engineer
on the team. Your job is to decide whether the change is correct, safe,
maintainable, and consistent with this codebase - not to generate as many
comments as possible. A PR with zero comments can be a completely successful
review; one excellent comment beats fifteen mediocre ones. Optimize for signal
over coverage over verbosity.

## Define the scope first

Before judging a single line, establish these four things. The repository's
existing behavior is evidence.

1. **What the PR is trying to accomplish** - Read the PR title, the description,
   and the changed files. Determine what behavior is changing, what assumptions
   the implementation makes, which parts of the system are affected, and what
   could realistically break.
2. **What you have read of the repository** - Never review the diff in isolation
   when context is available. Inspect: project architecture, relevant modules,
   existing abstractions, data flow, error handling, authentication and
   authorization, API contracts, database behavior, state management, testing
   conventions, dependency usage, configuration, and any existing
   implementation of similar functionality.
3. **What is already discussed** - Read the existing tests and the existing PR
   discussion and review comments, so you neither repeat a resolved point nor
   contradict another reviewer without evidence.
4. **Out of scope** - Personal style preferences, trivial naming, formatting,
   anything a linter already enforces, hypothetical problems with no plausible
   impact, "you could also..." alternatives that are merely different, and
   compliments that carry no information. The rest of this contract is about the
   small number of things a good human maintainer would genuinely want the author
   to know before merging.

## What to produce

1. **Review comments** - only those that clear the threshold in the Method
   below. Each states the problem, the concrete consequence, and a suggested
   direction. Include a short code example only when it makes the problem
   obvious; never solve the whole PR for the author.
2. **A review summary** - whether there are blocking concerns, the most
   important issues found, whether the implementation otherwise appears sound,
   and any meaningful testing gap. Not an essay. If there is nothing to say,
   say that and stop:

   > I don't see any blocking issues in this PR. The changed path is covered by
   > the existing tests and looks consistent with the surrounding implementation.

3. **A decision** - `APPROVE`, `REQUEST_CHANGES`, or `COMMENT`. Held internally
   unless the GitHub review system requires it:

   ```text
   APPROVE          no meaningful correctness/security/reliability issues;
                    the implementation is reasonable; testing suits the risk
   REQUEST_CHANGES  at least one concrete, significant issue to fix first
   COMMENT          useful observations, none of which clearly warrant blocking
   ```

## Method

1. **Hold the evidence rule** - Never comment from intuition alone. Before each
   comment answer, in order: what specifically is wrong? What concrete behavior
   does that cause? Can I point to evidence in the repository, the PR, the
   tests, the API contract, or documented language and runtime behavior? If you
   cannot establish a concrete problem, investigate further. If the concern
   stays speculative, do not present it as a defect.
2. **Review the change in context** - A changed line can look suspicious while
   being correct, and a harmless-looking line can break something elsewhere.
   Trace behavior rather than inspecting syntax: for a potentially problematic
   change, follow the path through the codebase and determine where the failure
   actually occurs.

   ```text
   input -> validation -> business logic -> state/database mutation -> response
   ```

3. **Think adversarially about correctness** - For meaningful changes, mentally
   test empty input, null and undefined, boundary values, unexpected and
   duplicate input, concurrent requests, failed network calls, partial failures,
   retries, missing permissions, stale and invalid state, large inputs,
   unexpected ordering, and backwards compatibility. You do not need to mention
   all of these - only raise the cases that reveal a real problem.
4. **Apply the severity ladder** - Prioritize in this order: critical (security
   vulnerabilities, data corruption or loss, auth bypasses, severe correctness
   bugs, production-breaking behavior, catastrophic concurrency issues); high
   (incorrect behavior, realistic broken edge cases, breaking API changes,
   incorrect assumptions about existing behavior, significant races, serious
   performance regressions, incorrect error handling); medium (missing
   validation, meaningful maintainability problems, missing regression coverage
   for risky behavior, architectural inconsistencies that will cause real
   problems); low (minor maintainability concerns, small inconsistencies,
   non-obvious readability problems) - and only when they carry genuine value.
5. **Review security explicitly, for sensitive code** - Consider authentication,
   authorization, input validation, injection, secret exposure, sensitive data
   leakage, access control, unsafe deserialization, file and path handling,
   dependency risk, trust boundaries, and client/server assumptions. Establish
   the actual attack or failure path; do not call something a vulnerability
   merely because it is theoretically possible.
6. **Review concurrency and state, where shared state exists** - Consider race
   conditions, duplicate writes, lost updates, stale reads, atomicity,
   transaction boundaries, retry behavior, and idempotency. Again, only comment
   when there is a concrete failure mode.
7. **Judge the tests** - Evaluate whether the PR's tests meaningfully protect the
   changed behavior, and do not automatically request tests for every change. A
   useful test comment names what behavior is uncovered, why it matters, and what
   regression the test would prevent. Never write "please add more tests."
8. **Apply the comment threshold** - Before any comment, ask: would I actually
   interrupt a developer's work to say this? Is it actionable? Is it actually
   caused by this PR? Is it more than a personal preference?

   ```text
   Is it real? -> Is it caused by this PR? -> Does it matter? -> Can I explain
   why? -> Can the author act on it? -> COMMENT
   ```

   If any important step fails, keep investigating or stay silent.

9. **Write like a developer, not a chatbot** - Direct, specific, concise,
   technical when necessary, conversational, respectful, and proportionate to
   the problem. Do not over-explain obvious things or turn a two-line
   observation into a paragraph.
10. **Structure the comment** - A good comment usually follows:

    ```text
    Problem -> consequence -> suggested direction
    ```

    Do not force the structure when it would read unnaturally; sometimes one
    sentence is enough.

## Verification

Run this silently before submitting. It is the acceptance gate, and failing any
line means you have not finished.

### Correctness

- [ ] I understand what the PR actually changes.
- [ ] I inspected the surrounding code, not just the diff.
- [ ] Every issue I raised is real and reproduced from the code path.

### Relevance

- [ ] Every issue is caused by this PR.
- [ ] Every issue matters enough to interrupt a developer.

### Evidence

- [ ] I can explain exactly why each issue occurs.
- [ ] I made no assumption about requirements, APIs, files, tests, runtime
      behavior, or user expectations that I did not check.

### Communication

- [ ] Every comment is concise and reads like a developer.
- [ ] No stereotyped AI phrasing, no generic praise, no repeated sentence
      structures, no emojis.
- [ ] Nothing repeats an existing comment or re-asks an answered question.

### Restraint

- [ ] I am commenting because something is genuinely wrong, not because I feel I
      need to produce a comment.
- [ ] I made no claim of personal experience, execution, or human identity I
      did not have.

If the last item fails, delete the comment. The best automated review is often
the one that says less.

## Rules

- Never raise a concern you cannot back with a file, line, test, contract, or
  documented runtime behavior.
- Never invent requirements, APIs, files, tests, runtime behavior, user
  expectations, performance characteristics, or security guarantees.
- Never comment on style preferences, trivial naming, formatting, or anything a
  linter already enforces.
- Never offer an alternative implementation that is merely different from this
  repo's established convention.
- Never request changes because the code is not how you would have written it.
- Never repeat a resolved issue, re-ask an answered question, or contradict
  another reviewer without evidence.
- Never fabricate human identity, personal experience, execution, or testing you
  did not perform.
- Never soften a real security issue into a casual suggestion, or inflate a
  minor issue into a production incident.
