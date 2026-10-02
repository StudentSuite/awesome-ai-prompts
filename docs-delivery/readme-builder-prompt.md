# Reusable prompt: README builder

Copy-paste the block below into any AI coding agent to build a comprehensive
README from scratch - honest, useful, and structured for someone encountering
the project for the first time.

Keywords: readme, project docs, badges, quick start, installation, getting started

---

Build a README.md for this repository from scratch (or rewrite the existing
one). The goal: a README that helps a newcomer understand what this project
does, why they'd use it, and how to get started in under 2 minutes.

## Steps

1. **Understand the project** - Read the code, existing docs, package
   manifests, and any config to understand: what it does, who it's for, what
   problem it solves, and how it's different from alternatives. Do not guess
   from the project name alone.
2. **Structure the README** - Use this order (adapt based on project needs):
   - One-sentence description of what it is
   - 2-3 sentence value proposition (why use this)
   - Quick start (install + minimal usage in under 5 commands)
   - Features or capabilities (what it can do)
   - Configuration (env vars, config files, CLI flags)
   - Development setup (contributing, running locally)
   - License
3. **Write honest copy** - Describe what the project actually does, not what
   you wish it did. Use the project's own terminology. Avoid marketing fluff,
   superlatives, and buzzwords. If the project has limitations, mention them.
4. **Show real examples** - Include code snippets that actually work. Verify
   every command you document by reading the code or running it. Show real
   output where it helps understanding.
5. **Add badges and links** - Include build status, license, and any other
   relevant badges. Link to CONTRIBUTING.md, LICENSE, and related docs.
6. **Verify everything** - Every command in the README must work. Every link
   must resolve. Every code snippet must be syntactically correct for the
   project's language.

## Verification

- [ ] The README answers what the project does, who it is for, and how to run
      it, above the fold.
- [ ] Every command in it was run and worked; every link resolves.
- [ ] Every code snippet produces the output shown.
- [ ] Nothing is described that the project does not do.
- [ ] No placeholder sections remain, and the copy is short paragraphs, code
      blocks, and lists.
- [ ] Badges point at real, working workflows.

## Rules

- Never write a README that sounds impressive but doesn't answer "what does
  this do and how do I use it?"
- Never include commands you haven't verified work.
- Never add placeholder sections ("TODO: add more docs") - either write the
  section or remove it.
- Keep the README scannable: short paragraphs, code blocks, and lists. No walls
  of text.
