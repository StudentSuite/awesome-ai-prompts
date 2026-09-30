# Translations

Translated prompts live here. English is the source of truth; this tree is a
downstream mirror of it and never the other way round.

## Layout

```text
i18n/
  README.md              this file: layout, conventions, upstream tracking
  <lang>/
    README.md            per-language status and a list of what is translated
    <category>/
      <slug>-prompt.md   translated copy of <category>/<slug>-prompt.md
```

`<lang>` is a lowercase language code: `es`, `hi`, `pt-br`. `<category>` is one
of the 13 category folder names, and `<slug>-prompt.md` is byte-for-byte the
same filename as the English prompt it mirrors. Keeping the category inside the
language folder, rather than flattening to `i18n/<lang>/<slug>-prompt.md`, means
the upstream mapping is readable from the path alone: drop the `i18n/<lang>/`
prefix and you have the English file.

A separate top-level folder per language was chosen over parallel repositories
because a contributor translating a prompt should need one clone and one pull
request, not a second remote with its own issue tracker, labels, and review
queue. The English repo's gates should cover translated files too, so that a
translation cannot rot in a place CI never looks.

## What belongs here

A translated prompt keeps the full structure of the English original: the same
H1 and `---` divider, the same four parts, and a `Keywords:` line written in the
target language, because that is the language a reader will search in.

```text
# Reusable prompt: <title, translated>

<usage note, translated>

Keywords: <terms in the target language, lowercase>

---

<prompt body, translated>
```

`scripts/check-links.sh` requires exactly one non-empty `Keywords:` line above
the divider. It enforces the English lowercase-and-comma-separated format only
on English prompts; a translated line just has to be there and have content, so
that accented and non-Latin scripts are not rejected by an English character
class.

## Why no prompt here is machine-translated

These prompts are prescriptive instructions that a coding agent follows
literally. A prompt body is not prose: "Delete the staging branch" and "Never
delete the staging branch" are one word apart and produce opposite actions. A
machine translator does not know which one it is looking at, and nothing in the
gate chain can tell afterwards that it got it backwards. The verification
discipline this repo is built on would not survive translation by machine.

So every translated file here is written by a person who will paste it into a
real agent and watch what it does. That is slower than running a translation
API over the folder, and it is the only version worth shipping.

## Tracking upstream

The English prompt is authoritative. When it changes, the translation is stale
until someone updates it, and this file's status table is how that becomes
visible.

Compare the translation against the English file it mirrors:

```bash
# what has drifted in the English original since the translation landed
diff <(git show origin/main:<category>/<slug>-prompt.md) <lang>/<category>/<slug>-prompt.md
```

A translation that is only the title and usage note may be behind on the prompt
body, which is the part that matters. Keep the status table in
`i18n/<lang>/README.md` honest: mark a prompt current only when its body has
been reviewed against the current English text, and say who reviewed it.
