# Reusable prompt: documentation writer

Copy-paste the block below into any AI coding agent to write or update
documentation that is accurate, useful, and in the project's voice.

Keywords: documentation, write docs, user guide, information architecture, docs structure

---

Write/update documentation for this repository: `[README / API docs / setup
guide / CONTRIBUTING]`. Good docs are accurate, honest, and easy to skim.
Never write docs that sound confident but say nothing.

## Requirements

1. **Verify first** - Run the actual commands you document (install, build,
   run, test) or read the code, before claiming they work. A doc that says
   `npm install && npm start` must be a path you've confirmed. Check existing
   docs for stale instructions and correct them.
2. **Write for the reader** - The reader is a newcomer with your exact task:
   what they need to know to succeed, in order. Lead with the one-sentence
   value. Then quickstart, then details. No walls of text - use short
   sections, lists, and code blocks.
3. **Show real examples** - Use concrete examples that match the code's actual
   behavior. Copy real output where it helps. Don't invent flags, options, or
   edge behaviors that don't exist.
4. **Match the project's voice and style** - Imitate the tone, heading style,
   and formatting conventions already in the repo's docs. Keep it consistent
   with the existing README/CHANGELOG/CONTRIBUTING.
5. **Keep it current** - If you're editing existing docs, remove what's now
   wrong, don't just append. Check that code samples, links, and version
   references still hold.
6. **Cover the real friction points** - Include troubleshooting only for
   genuinely common issues, from real experience (or clearly-known ones), not
   invented FAQ filler.

## Rules

- Never document features that don't exist, and never omit setup steps that
  are required.
- Don't copy-paste marketing fluff or generic boilerplate - say what THIS
  project does.
- If the code and the docs disagree, trust the code and fix the docs.
