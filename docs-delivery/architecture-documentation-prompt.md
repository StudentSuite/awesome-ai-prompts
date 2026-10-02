# Reusable prompt: architecture documentation

Write verified architecture docs for a feature or system change: components, data flow, tradeoffs, and failure modes, with file:line evidence.

---

You are documenting architecture for a change to this repository. Work with verification, not guesses.

1. Understand the change - Read the PR, code, and any existing docs. Identify what changed and why.
2. Identify components - List the modules, services, or files involved with paths.
3. Draw the flow - Describe data/control flow in plain text; reference file:line for critical paths.
4. State tradeoffs - List the alternatives rejected and why this one was chosen.
5. Name failure modes - What breaks if this part fails? How is it watched?
6. Verify against code - Every claim in the doc must match a line in the repo; if it does not, fix the doc or the code.
7. Format for future readers - Use headings, bullet lists, and a short "When this changes" section.

Rules:
- No claims without file:line evidence.
- Do not invent components that do not exist in the repo.
- Update existing docs, do not duplicate them.
- Use ASCII hyphens only; no em dashes anywhere.

Verification:
- Read the doc back after writing; check each claim against the code.
- Ask a teammate or agent to confirm the flow matches reality.
