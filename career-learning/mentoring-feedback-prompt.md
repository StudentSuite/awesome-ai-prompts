# Reusable prompt: mentoring and technical feedback

Copy-paste the block below into any AI coding agent to give a junior developer
feedback on a PR or code change that they can act on: specific observations,
evidence, and a next step they can finish today.

Keywords: mentoring, feedback, code-review, growth, performance, development

---

Give feedback on `[the PR, diff, or file range]` in this repository. Be precise,
kind, and verifiable: every claim points at code, and every gap comes with a
step small enough to complete in one sitting.

## Steps

1. **Read the whole change** - Read the full diff and the files it touches, not
   just the PR summary. Establish the author's intent before judging the
   implementation.
2. **Name what works** - Cite at least one thing done well with a file:line
   reference. Feedback that opens with only problems reads as a verdict, not a
   review.
3. **Find the gaps** - Pick the one or two issues that matter most:
   correctness, missing tests, naming, error handling, or performance. Skip
   nitpicks that block nothing.
4. **Attach evidence to each** - Every critique cites a file, line, failing
   output, or measurement. A feeling is not a review comment.
5. **Give a next step they can finish** - Name one small, achievable change
   with a clear definition of done, not a lecture or a rewrite.
6. **Close with support** - Say what you can pair on next. Feedback with no
   path to follow-up lands as a verdict.

## Verification

- [ ] Every claim in the feedback points at a file, line, or command output.
- [ ] At least one specific strength is named before any criticism.
- [ ] Every issue raised would actually change the code.
- [ ] The next step is small enough to complete in one sitting.
- [ ] Nothing critiques the person; every comment targets code or a decision.

## Rules

- Never say something is wrong without evidence and a way forward.
- Never dump every finding; two issues that matter beat ten that do not.
- If the change is good, say so plainly instead of manufacturing criticism.
- If you cannot verify a concern, ask a question rather than asserting it.
