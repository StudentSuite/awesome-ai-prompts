# Reusable prompt: commit checklist & consistency gates

Copy-paste the block below into any AI coding agent to add automated PR gates
that keep a repository's derived artifacts in sync - so forgetting the
housekeeping becomes structurally impossible.

Keywords: commit, checklist, conventional commits, pre commit hook, consistency, gates

---

Build a commit checklist for this repository: deterministic checks that fail
CI when derived artifacts drift out of sync. Repos rot through forgotten
bookkeeping, not bad intentions; make the bookkeeping unforgettable without
drowning contributors in noise.

## Steps

1. **Inventory the invariants** - Read the repo structure first and list
   every pair of artifacts that must agree: index files vs actual content,
   changelog vs newly added files, counts vs reality, naming conventions,
   folder vs section mappings. Each invariant becomes one check.
2. **Express checks as deterministic rules** - Every check must be a
   file-graph or diff fact that either holds or does not: "every X is listed
   in Y", "every added Z has a changelog entry". Reject vague style opinions;
   if a rule needs taste to evaluate, it is not a gate.
3. **Put logic in a script, not the workflow** - Implement the checks in a
   versioned, locally runnable script; keep CI as a thin job that invokes it.
   Minimal permissions, no third-party actions unless unavoidable, and lint
   the script itself.
4. **Scope additive rules by diff** - Rules about new content must use the
   merge-base diff against the target branch
   (`git diff --name-only --diff-filter=A <base>...HEAD`), so pre-existing
   content never triggers false positives and multi-file PRs work naturally.
5. **Make failures actionable** - Every failure names the exact fix: the
   missing entry, the expected line, the mismatched count. Print a pass/fail
   summary so authors can self-serve instead of ping-ponging with review.
6. **Wire enforcement deliberately** - Add the workflow, then make its job a
   required status check on the default branch. Decide explicitly whether
   admins can bypass (direct pushes) or everything goes through PRs, and
   state which in the PR description.
7. **Verify both directions before merging** - Run the suite green on the
   current state first; then prove each check fires by temporarily breaking
   one invariant at a time (unlisted file, missing entry, stale count). A
   gate that has never failed is untested code.

## Rules

- No gate you cannot run locally in one command.
- Document every gate in the contribution docs in the same PR that adds it.
- Keep the suite fast and quiet when green - gates that cry wolf get deleted.
- Enforcement changes are stated in the PR description, never snuck into an
  unrelated change.
