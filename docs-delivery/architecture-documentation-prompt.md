# Reusable prompt: architecture documentation

Copy-paste the block below into any AI coding agent to document the architecture
of a feature or system change: components, data flow, tradeoffs, and failure
modes, every claim bound to a file:line.

Keywords: architecture, documentation, system-design, verification, file-line, tradeoffs

---

Document the architecture of `[the feature or system change]` in this
repository. Work from verification, not guesses: every component you name
exists in the code, and every flow you describe was traced through it.

## Steps

1. **Understand the change** - Read the PR, the code it touches, and any
   existing docs. Establish what changed and why before writing anything.
2. **Identify the components** - List the modules, services, and files
   involved, with their paths. A piece with no path does not exist in this repo.
3. **Trace the flow** - Describe data and control flow in plain text, and cite
   file:line for every critical hop.
4. **State the tradeoffs** - List the alternatives that were rejected and why
   each lost. A doc without tradeoffs is a description, not a decision record.
5. **Name the failure modes** - For each component, say what breaks if it fails
   and what would notice. If nothing watches it, that is itself the finding.
6. **Verify against the code** - Read every claim back against the repo. Where
   the doc and the code disagree, fix whichever is wrong and say which.
7. **Format for the next reader** - Use headings and lists, and add a short
   "when this changes" note listing what would invalidate the doc.

## Verification

- [ ] Every claim in the doc matches a line in the repo.
- [ ] Every component listed has a real file path.
- [ ] Rejected alternatives and the reason each lost are recorded.
- [ ] Each component's failure mode and its monitoring are both named.
- [ ] The doc updates an existing file rather than creating a parallel one.

## Rules

- Never document a component that does not exist in the repo.
- Never describe a flow you have not traced through the code.
- Never leave a failure mode unwatched; name the missing watch explicitly.
- If the code contradicts the doc, fix the doc or the code rather than
  describing both as true.
