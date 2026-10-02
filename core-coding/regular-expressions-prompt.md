# Reusable prompt: regular expressions that don't bite

Copy-paste the block below into any AI coding agent to write or repair a
regular expression the way a senior engineer would: a defined purpose, a corpus
of cases that proves the behavior, and a check that the pattern cannot blow up
on adversarial input.

Keywords: regex, regular expression, pattern matching, escaping, catastrophic backtracking, grep

---

Help me write `[what the regex must match]` in `[language or stack]`. Treat a
regex as risky code, not a magic one-liner: it needs a stated purpose, tests
against real inputs, and evidence that it cannot hang on bad input. Write it
only after we agree on the behavior it must have.

## Steps

1. **State the purpose in plain words** - What must match, what must not, and where the pattern runs: validation, extraction, a hot path, or user-supplied input. If the plain statement is hard to write, the regex is the wrong tool - say so and propose ordinary string handling.
2. **Choose the simplest expression** - Prefer the smallest pattern that meets the purpose. A string method or a tiny state machine often beats a regex, and a language-provided parser for a structured format (JSON, URL, email) beats both.
3. **Anchor and bound it** - Anchor start and end or use word boundaries where the behavior demands. Match what the caller needs, not a fuzzy subproblem, and avoid dot-all or unconstrained groups.
4. **Build a corpus and test** - List must-match, must-not-match, and edge inputs (empty, whitespace, unicode, mixed case, very long, lookalikes, embedded newlines), run them in a throwaway test, and paste the results rather than asserting them.
5. **Hunt catastrophic backtracking** - Inspect for nested quantifiers and alternatives that rescan the same text, `(a+)+` and `(a|a)*`, especially on untrusted input. Bound the input length, or time the worst-case input from step 4 and show it returning fast.
6. **Ship the corpus as a test** - The adopted pattern lands with its corpus as a repeatable test that fails if the behavior changes, plus a short comment giving the purpose, the corpus, and why this construction. Regexes are for text with a shape; parsers are for formats with grammar.

## Verification

- [ ] The corpus test ran, showing both the passes and the intended non-matches.
- [ ] The worst-case adversarial input from the corpus was timed, and it returns fast.
- [ ] Any nested quantifier over user-controlled input is bounded, or the pattern was rewritten to remove it.
- [ ] The corpus test landed in the repo in the same change as the pattern.
- [ ] The final pattern is pasted, with a comment stating the purpose and the corpus.

## Rules

- Never write a regex without running it against the agreed corpus and showing
  the output.
- Never accept a pattern with nested loops over the same input on
  user-controlled data without bounding it first.
- Prefer parser, string, or index operations over a regex when the format is
  structured. Regexes are for matching text with a shape; parsers are for
  formats with grammar.
- No pattern change in production code without the corpus test landing in the
  same change.
