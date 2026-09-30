# Reusable prompt: changelog & release notes

Copy-paste the block below into any AI coding agent to turn git history into
a clear, honest changelog for a release.

Keywords: changelog, release notes, keep a changelog, versions, commit grouping, release

---

Write the release notes/changelog for `[version / tag / range of commits]` of
this repository, based on the actual git history. Read the commits - don't
write from memory or from the release title alone.

## Steps

1. **Gather the commits** - `git log` the range (compare with the previous
   release tag). Read titles and the diffs for anything ambiguous. Use
   conventional-commit prefixes if the repo uses them.
2. **Categorize** - Group changes as: **Added**, **Changed**, **Fixed**,
   **Removed**, **Deprecated**, and **Security** (match the repo's existing
   changelog convention if it has one). Order within each group by importance
   or by tag/date as the repo does.
3. **Summarize user-visible impact** - Each entry should say what changed and
   (where it matters) what the user/developer must know: a breaking change
   must be called out loudly with migration guidance or a link to it.
4. **Be accurate** - Include only what actually landed. Include dependency
   bumps only if they affect users. Never pad with "improved performance"
   unless a commit actually did that.
5. **Follow conventions** - Keep the repo's existing changelog format,
   heading style, and versioning scheme (SemVer if the repo uses it).

## Rules

- Never invent entries or describe commits you haven't read.
- Breaking changes go at the top of their section and are flagged as such.
- If the repo uses auto-generated release notes, improve and reconcile with
  them rather than duplicating or conflicting.
- Verify the version numbers and links you reference exist.
