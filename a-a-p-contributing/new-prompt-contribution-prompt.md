# Reusable prompt: new prompt contribution

Copy-paste the block below into any AI coding agent to add a new prompt to
this repository, in a form a maintainer can merge on the first pass.

Keywords: add a prompt, contribute, new prompt, pull request, authoring, gates

---

Help me add a new prompt to this `awesome-ai-prompts` repository. Every prompt
here follows strict conventions and CI enforces them, so read the rules before
writing anything. Do not write the file until we have agreed on the idea.

## Steps

1. **Read the conventions first** - `CONTRIBUTING.md`,
   `.github/PROMPT_TEMPLATE.md`, and two or three existing prompts in the
   target category. Note the structure: H1 title, usage note, `---` divider,
   prompt body.
2. **Confirm the idea is new** - List the closest existing prompts and say how
   this one differs. If it duplicates one, stop and propose a distinct idea.
   Never add a near-copy.
3. **Draft after the divider** - Numbered `## Steps` with bold lead-ins, a
   `## Rules` list, and a `## Verification` section naming actual commands.
   Ground it in "verify, don't guess": no claim without a way to check it.
4. **Follow the repo's rules** - Tool-agnostic (Claude, ChatGPT, Copilot,
   Cursor, opencode) and self-contained: everything the user pastes lives
   inside the block. No em dashes, use an ASCII hyphen. Flag `[spec]` only
   for multi-section prompts covering big, risky work.
5. **Name, place, and index it** - `kebab-case-action-prompt.md` in the
   matching category folder, never at the repo root. Add one README section
   entry ending in a period, bump that category's Contents count, and add a
   `## [Unreleased]` line in `CHANGELOG.md` naming the file in backticks.
6. **Verify before claiming done** - Run `bash scripts/check-links.sh`,
   `bash scripts/check-consistency.sh`, and markdownlint on the changed
   files with `npx --yes markdownlint-cli2@0.17.2 <file>`. Show the script
   output; never just your word that they passed.
7. **Commit and PR** - One conventional commit (`docs: add <name> prompt`),
   reference any related issue, and write a PR description explaining why this
   prompt belongs here.

## Verification

- [ ] The closest existing prompts are listed and the difference is stated, so this is not a near-copy.
- [ ] The body has `## Steps`, `## Verification`, and `## Rules`, and every "verify" instruction names a real command.
- [ ] The README section gains exactly one entry and the Contents count matches the folder.
- [ ] A `## [Unreleased]` CHANGELOG entry names the new file in backticks.
- [ ] `check-links.sh`, `check-consistency.sh`, and markdownlint ran, with the outputs pasted.

## Rules

- Never write a prompt that demands verification without naming the actual
  command or check that runs it.
- Never say a check passed unless you ran it and saw the output.
- Keep the change tight: one prompt per PR, no unrelated wording or format
  edits to existing prompts.
- If a rule is ambiguous, ask before writing.
