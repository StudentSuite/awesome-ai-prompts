# Reusable prompt: spec prompt schema [spec]

Copy-paste the block below into any AI coding agent to author a spec prompt
for this catalog: the repo's heavy format for big, risky work that demands
scope, hard constraints, and evidence-gated verification.

Keywords: spec, specification, requirements, schema, protocol, constraints

---

Write `[the new prompt]` as a spec prompt in this repository - the format for
tasks where failure is expensive and agent claims need proof. Match the field
contract below exactly, and register the result in the index with the spec
badge.

## Earning the badge

A prompt qualifies as a spec when it must prevent expensive failure: audits,
migrations, platform verification, security work, anything whose wrong answer
ships a regression. Quick single-answer tasks do not qualify - trim those to a
one-pager. Approved spec prompts carry the light-blue `[spec]` badge in the
README and are registered in `SPEC_PROMPTS` in
`scripts/check-consistency.sh`.

## Field contract

| Field        | Rule                                                                                                 |
| ------------ | ---------------------------------------------------------------------------------------------------- |
| H1 title     | `# Reusable prompt: <name> [spec]` - the suffix is mandatory                                         |
| Usage note   | 1-2 lines naming when the heavy format applies                                                       |
| Divider      | A lone `---` between the note and the prompt block                                                   |
| Scope        | `## Define the scope first` - forces platforms, inputs, outputs, and out-of-scope before work starts |
| Deliverables | `## What to produce` - numbered artifacts, each with its evidence shape                              |
| Method       | `## Method` - numbered commands; baseline and measure first where measurable                         |
| Verification | `## Verification` - checkbox gate, exhaustive and every item checkable                               |
| Rules        | `## Rules` - hard "Never" lines naming the risks the gate protects                                   |
| Evidence     | No bare claims; every assertion bound to a run log, matrix, or file:line                             |
| Index        | README entry with badge, `SPEC_PROMPTS` registration, changelog entry                                |

## Method

1. Decide the badge with the qualifying rule above, before writing anything.
2. Force the scope: name platforms, inputs, outputs, and what is out of
   scope. Work cannot start until scope is stated.
3. Define the deliverables and the evidence shape each one produces.
4. Write the Verification gate, then the Rules that protect it.

## Verification

- [ ] `[spec]` suffix, README badge, `SPEC_PROMPTS`, and changelog entry are
      all in sync.
- [ ] Scope-first is enforced - no work before scope is stated.
- [ ] Every Verification item is checkable by someone new to the task.
- [ ] Out-of-scope is stated, so no unverifiable "done" is possible.
- [ ] `bash scripts/check-links.sh` and `bash scripts/check-consistency.sh`
      pass clean.

## Rules

- Never badge a task a one-pager covers; cheap work gets the cheap format.
- Never end a spec prompt without an explicit acceptance gate.
- Never accept "done" without the evidence the gate names.
- Never register a spec prompt without its badge, index entry, and checks.
