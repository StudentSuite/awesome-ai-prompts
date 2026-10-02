# Reusable prompt: dependency upgrade

Copy-paste the block below into any AI coding agent to upgrade a dependency
safely - change what breaks, understand what changed, and verify.

Keywords: dependency upgrade, version bump, breaking change, renovate, outdated packages, bump

---

Upgrade `[package]` from `[old version]` to `[new version]` in this repository.
Do this carefully: an upgrade is a code change with its own risk, not a
package.json edit.

## Steps

1. **Survey the blast radius** - Find everywhere the package is used: imports,
   config, build tooling, CI, docs. Read the code that depends on it so you
   know what behavior is actually relied on.
2. **Read the changelog** - Review the release notes/migration guide between
   the two versions. List the breaking changes, deprecations, and security
   fixes that apply to this repo's usage. Cite what you find - don't summarize
   from memory.
3. **Update the manifest** - Change the version in the appropriate lockfile/
   manifest. If the project uses a lockfile, update it through the project's
   tooling (e.g. `npm install`, `pip install`, `go mod tidy`) rather than by
   hand.
4. **Fix what breaks** - Run the test suite and the repo's checks. For each
   failure, read the actual API change and migrate the code properly. Do not
   disable tests or silence errors to make it pass.
5. **Verify behavior** - Exercise the affected paths beyond the tests where
   practical. Check that deprecated-but-warned usage is cleaned up.
6. **Document** - Note the upgrade in the changelog if the repo keeps one, and
   call out any breaking changes or behavioral differences for consumers.

## Verification

- [ ] Every import, call site, and config touch of the package was found before
      the change.
- [ ] The changelog and migration guide between the two versions were read, not
      skimmed.
- [ ] The upgrade was run against the repo's real checks, with output shown.
- [ ] Affected paths were exercised beyond the test suite where practical.
- [ ] The change is confined to this one dependency; no unrelated bump rode
      along.
- [ ] Any required runtime or language version change was raised rather than
      absorbed.

## Rules

- Never upgrade just to be on the latest version - the upgrade must be
  justified (security, bugfix, feature, or explicit request).
- Never mix unrelated dependency changes into the same commit.
- If the new version needs a different runtime/Node/Python/Go version, stop and
  flag it instead of silently changing the environment.
- Verify with the repo's real checks; don't claim green CI you didn't see.
