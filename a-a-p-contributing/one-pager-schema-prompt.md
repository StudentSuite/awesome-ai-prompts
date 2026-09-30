# Reusable prompt: one-pager prompt schema

Copy-paste the block below into any AI coding agent to author a one-pager
prompt for this catalog: the repo's compact format for quick, well-scoped
tasks. This file is itself a one-pager - the block you write must fit the
same budget.

Keywords: one pager, brief, scope, ticket, planning, requirements

---

Write `[the new prompt]` as a one-pager in this repository - a
self-contained prompt for one quick task that fits on a single printed page.
Match the field contract below, then verify the result against the same
checks this file satisfies.

## Field contract

| Field        | Rule                                                             |
| ------------ | ---------------------------------------------------------------- |
| H1 title     | `# Reusable prompt: <kebab-case name>`, no `[spec]` suffix       |
| Usage note   | 1-2 lines explaining when to paste the block                     |
| Divider      | A lone `---` between the note and the prompt block               |
| Opening      | One imperative sentence with `[placeholders]` naming the task    |
| Steps        | `## Steps` - numbered, each step names the action and its output |
| Verification | `## Verification` - checkbox list the agent must satisfy         |
| Rules        | `## Rules` - 3-5 "Never/No/If" lines that price mistakes         |
| Size         | Prompt block ~45 lines / ~550 words max; whole file one page     |
| Extras       | No extra sections, no sub-tasks, no references to other prompts  |

## Method

1. Name the single task the prompt completes, in placeholders.
2. Keep one success path; do not branch on scenarios.
3. Build Steps, then derive Verification and Rules from what could go wrong.
4. Cut until the block fits the page - cut steps, never verification.

## Verification

- [ ] The whole file fits on one printed page (block `<=` 45 lines or ~550
      words).
- [ ] Every field in the contract above is present, and nothing beyond it.
- [ ] Naming follows `kebab-case-prompt.md` in the matching category folder.
- [ ] Indexed in the README, and `bash scripts/check-links.sh` passes clean.

## Rules

- Never write a one-pager for a task that needs scope negotiation or a
  verification matrix - that is a spec prompt.
- Never exceed the budget by dropping verification; drop optional steps.
- Never reference other prompts or assume context a stranger lacks.
