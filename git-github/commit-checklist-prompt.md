# Reusable prompt: commit checklist & consistency gates

Copy-paste the block below into any AI coding agent to add automated PR gates
that keep a repository's derived artifacts in sync - so forgetting the
housekeeping becomes structurally impossible.

Keywords: commit, checklist, conventional commits, pre commit hook, consistency, gates

---

Build a commit checklist for this repository: deterministic checks that fail CI
when derived artifacts drift out of sync. Repos rot through forgotten
bookkeeping, not bad intentions; make the bookkeeping unforgettable without
drowning contributors in noise.

## Steps

1. **Inventory the invariants** - Read the repo structure and list every pair
   of artifacts that must agree: index vs content, changelog vs new files,
   counts vs reality, naming, folder-to-section mappings. One pair, one check.
2. **Express checks deterministically** - Every check is a file-graph or diff
   fact that holds or does not: "every X is listed in Y", "every added Z has a
   changelog entry". Reject style opinions; a rule needing taste is not a gate.
3. **Keep logic in a script** - Implement the checks in a versioned, locally
   runnable script; let CI be a thin job that invokes it. Minimal permissions,
   no third-party actions unless unavoidable, and lint the script itself.
4. **Scope additive rules by diff** - Rules about new content use the
   merge-base diff against the target branch, scoped to added files with
   `git diff --name-only --diff-filter=A <base>...HEAD`, so pre-existing content
   never triggers false positives.
5. **Make failures actionable** - Every failure names the exact fix: the
   missing entry, the expected line, the mismatched count. Print a pass/fail
   summary so authors self-serve.
6. **Wire enforcement and prove it** - Add the workflow, make its job a
   required status check, and state in the PR whether admins can bypass. Run
   the suite green, then prove each check fires by breaking one invariant at a
   time.

## Verification

- [ ] The repo's actual invariants were inventoried before any rule was
      written.
- [ ] Every rule is a deterministic pass/fail check, not a guideline.
- [ ] The logic lives in a script the repo can run, not inside workflow YAML.
- [ ] Rules about new content are scoped by diff rather than applied to the
      whole tree.
- [ ] Each failure message names the exact fix.
- [ ] The suite was run green and, separately, red against a deliberate
      violation.
- [ ] The gate is runnable locally in one command and is documented in the
      contribution docs in the same PR.

## Rules

- No gate you cannot run locally in one command.
- Document every gate in the contribution docs in the same PR that adds it.
- Keep the suite fast and quiet when green - gates that cry wolf get deleted.
- Enforcement changes are stated in the PR description, never snuck into an
  unrelated change.
